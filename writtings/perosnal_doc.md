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
