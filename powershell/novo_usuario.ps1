    <#
        .SYNOPSIS
            Script para cadastro de novos usuários no AD e envio de email de confirmação.
     
        .DESCRIPTION
            O script processa o nome completo do usuário; 
            Checa se o login gerado (nome.ultimonome@) está disponível, se não cria-se um outro (nome.penultimonome.ultimonome@); 
            Envia email de confirmação;
            Força sincronia com Azure.
     
        .PARAMETER nomeCompleto    
        .PARAMETER emailSecundario
        .PARAMETER projeto
        .PARAMETER cargo
        .PARAMETER telefone
        .PARAMETER cpf
     
     
        .EXAMPLE
            PS C:\> .\novosUsuarios.ps1 'George Henrique Corcino Camboim' 'george.camboim@ee.ufcg.edu.br' 'IDEA' 'Dev. Graduando' '83966666666' '69456565687'
     
            Cadastrando  george.camboim@embedded.ufcg.edu.br
            MODO DETALHADO: Realizando a operação "New" no destino "CN=George Henrique Corcino Camboim,CN=Users,DC=embedded,DC=ufcg,DC=edu,DC=br".
            Cadastrado.
            Enviando Email de confirmação.
            Sincronizando com a nuvem.
     
                                                                                                                                                           Result
                                                                                                                                                           ------
                                                                                                                                                           Success
            Done
     
        .NOTES
            Pedro Lira
            @liraop
    #>
     
    Param ([string]$nomeCompleto,
           [string]$emailSecundario,
           [string]$projeto,
           [string]$cargo,
           [string]$telefone,
           [string]$cpf
           )
     
    ######
    ##
    ## Código do Marcin Krzanowicz 
    ## Encontrado aqui: https://l...content-available-to-author-only...n.com/2015/05/powershell-remove-diacritics-accents.html
    ##
    ######
    function Remove-StringLatinCharacters{
        PARAM ([string]$String)
        [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($String))
    }
     
     
    #####
    ##
    ## Função que checa se existe user.login já cadastrado no AD
    ##
    #####
    function Check-UsuarioExiste{
        PARAM ([string]$login_para_teste)
        $usuario = Get-ADUser -Filter {sAMAccountName -eq $login_para_teste}
        If ($usuario -eq $Null) { Return $false }
        Else {Return $true}
    }
     
    $global:primeiroNome = ""
    $global:ultimoNome = ""
    $global:iniciais = ""
    $global:nomeComIniciais = ""
    $global:userLogin = ""
    $global:emailInstitucional = ""
    $global:expirationDate = (Get-Date).AddYears(1)
    $global:pw = ConvertTo-SecureString '456Mudar?!' -AsPlainText -Force
    $global:cpf = "CPF:"+$cpf
     
     
    #####
    ##
    ## Função que processa o nome completo e popula as variáveis acima
    ##
    ##
    #####
    function ProcessaNome{
        PARAM ([string]$nomeCompleto)
     
        #### Divide o nome completo
        $global:nomeCompletoSplitted = $nomeCompleto.Split(' ')
        $tamanho_array = $nomeCompletoSplitted.Count
        $global:primeiroNome = $nomeCompletoSplitted[0]
        $global:ultimoNome = $nomeCompletoSplitted[$tamanho_array - 1]
     
        $nomes_do_meio = @()
     
        foreach ($nome in $nomeCompletoSplitted[1..($tamanho_array - 2)]) {
            if ($nome.Length -gt 2) {
                $nomes_do_meio += $nome
                $global:iniciais = $iniciais + $nome[0]+". "
            } else {
                $global:iniciais = $iniciais + $nome
            }
        }
     
        $global:nomeComIniciais = $primeiroNome+' '+$iniciais+' '+$ultimoNome
     
        $global:userLogin = $global:primeiroNome.ToLower() + '.' + $global:ultimoNome.ToLower()
        #remove acentos e caracteres especiais
        $global:userLogin = Remove-StringLatinCharacters -String $global:userLogin
     
        If (Check-UsuarioExiste -login_para_teste $global:userLogin) {
            $qtd_nomes = $nomes_do_meio.Length
     
            $global:userLogin = $global:userLogin.replace('.','.'+$nomes_do_meio[$qtd_nomes-1].ToLower()+'.')
            $global:userLogin = Remove-StringLatinCharacters -String $global:userLogin
        } 
     
        $global:emailInstitucional = $global:userLogin+'@embedded.ufcg.edu.br'
     
    }
     
     
    #####
    ##
    ## Função com corpo do email de confirmação e envio
    ##
    #####
    function EnviaEmaildeConfirmacao{
     
        $corpo_do_email ='
       <p>Olá, '+$nomeCompleto+',</p>
       <p>Sua conta @embedded foi criada seguindo o padrão:</p>
       <p>
          <strong>login:'+$emailInstitucional+'</strong></p>
       <p>
          <strong>senha temporária: 456Mudar?!</strong></p>
       <p>Esta senha temporária pode ser modificada numa visita a Sala do Suporte - se você já modificou a senha no momento de criar a conta, favor desconsiderar a senha temporária. 
          <br/>Após modificar a senha, você terá acesso ao 
          <a href="https://p...content-available-to-author-only...e.com/">https://p...content-available-to-author-only...e.com</a>&#160;onde poderá checar caixa email e outros serviços.<br/><strong>Contudo, a conta só fica ativa cerca de </strong>
          <strong>15 minutos </strong>
          <strong>após a cria</strong><span><strong>ç</strong></span><strong>ão da mesma. </strong>
          <br/></p>
       <p>Além do serviços Microsoft, acessíveis com o @embedded são:</p>
       <ul>
          <li>
             <a href="https://e...content-available-to-author-only...k.com/">Slack</a> do Embedded<br/></li>
          <li>
             <a href="http://e...content-available-to-author-only...u.br:8080/">JIRA</a> - Sistema de Tickets</li>
       </ul>
       <p>
          <br/>
       </p>'
     
        $From = "no-reply@embedded.ufcg.edu.br"
        $To = $emailSecundario
        $Subject = "Conta @embedded"
        $Body = $corpo_do_email
        $SMTPServer = "einstein.embedded.ufcg.edu.br"
        $SMTPPort = "25"
     
        Send-MailMessage -SmtpServer $SMTPServer `
                         -Port $SMTPPort `
                         -To $To `
                         -Cc suporte@embedded.ufcg.edu.br `
                         -From $From `
                         -Subject $Subject `
                         -Body $Body -BodyAsHtml `
                         -Priority high `
                         -Encoding ([System.Text.Encoding]::UTF8) 
    }
     
    ProcessaNome -nomeCompleto $nomeCompleto
     
    Try {
        Write-Host "Cadastrando "$emailInstitucional
     
        New-ADUser -GivenName $primeiroNome `
                -Name $nomeCompleto `
                -Surname $ultimoNome `
                -DisplayName $nomeCompleto `
                -SamAccountName $userLogin `
                -UserPrincipalName $emailInstitucional `
                -AccountExpirationDate $expirationDate `
                -AccountPassword $pw `
                -EmailAddress $emailInstitucional `
                -MobilePhone $telefone `
                -Enabled $true `
                -Title $cargo `
                -Department $projeto `
                -Description $cpf `
                -OtherAttributes @{'proxyAddresses'='SMTP:'+$emailInstitucional; 
                                   'physicalDeliveryOfficeName'=$emailSecundario;
                                   } `
                -Verbose
     
        Write-Host "Cadastrado."
        Try {
            EnviaEmaildeConfirmacao
            Write-Host "Enviando Email de confirmação."
            Write-Host "Sincronizando com a nuvem."
            Start-ADSyncSyncCycle -PolicyType Initial
        } Catch {
            Write-Host "Email não enviado."
        }
    } Catch {
        Write-Host "Usuário não cadastrado ou email não enviado."
    } Finally {
        Write-Host "Done"
    }
