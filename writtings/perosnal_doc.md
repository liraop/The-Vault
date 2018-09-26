# Summary
This document work both as documentation and learning aid.
You can find here the majority of concepts and/or guides that helped me to solve problems or get to know something new.

### [Certificates](#certs)
### [Keys](#keys)

# <a name=certs>Certificates</a>
There are two major categories of certificates:

#### Self-signed
<p> Overview: Can be generated using your own server.
<br>Uses: internal, development, testing;
</p>

## Generating a signed certificate

Once you have your domain root certificate, you can sign certificates for the uses noted above.
Say you need to generate certs for host 'ronaldo.brasil.com.br'

* Create a Private Key (.key)
```
openssl genrsa -out ronaldo.brasil.com.br.key 2048
```
Of course, you choose the parameters you need.

* Create a Certificate Signing Request (.csr)
Now, use this generated PK to create a request for a certificate.
```
openssl req -key ronaldo.brasil.com.br.key -new -sha256 -out ronaldo.brasil.com.br.csr
```

* Process the request and generate the certificate (.crt)
Final step
```
openssl x509 -req -in ronaldo.brasil.com.br.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out ronaldo.brasil.com.br.crt -days 500 -sha256
```

Now you have all the files needed to set up your services for the desired host.


#### CA-signed
<p>Overview: Requires a Certification Authority (CA) verification. [Let's Encrypt](https://letsencrypt.org/getting-started/) can be used.
<br>Use case: production </p>

# <a name=keys>Keys</a>

#### Adding keys to ssh

Make sure your platform has `openssh` installed and running. Check on your homedir if there `.ssh` directory. If not, create it.
Move your keys into the directory.

If your keys are [too open](https://stackoverflow.com/questions/9270734/ssh-permissions-are-too-open-error), close them:
```
chmod 400 ~/.ssh/id_key
```

Make sure ssh agent is running
```
eval $(ssh-agent -s)
```

Finally, add keys to ssh.
```
ssh-add ~/.ssh/id_key
```

Now the private keys is ready to be used by SSH client to connect with your pubkey somewhere over the rainbow.
