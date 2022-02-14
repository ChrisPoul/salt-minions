# Prerequisites
Before you can get started you need:
- A file with your credentials named **ccfs-igniters-sbx-002-ecb17f946e92.json**
- A public key named **id_rsa.pub** in the home directory inside the **.ssh** directory. The path would look as follows **~/.ssh/id_rsa.pub**
- A private key named **id_rsa** in the home directory inside the **.ssh** directory. The path would look as follows **~/.ssh/id_rsa.pub**
- A master node already running.
- The master node's **ip address** and it's **master.pub** key.

# Instructions
For this script to work all you need to provide are the **masters's ip address** and the **master.pub key**, then all you got to do is run the script.

Once **terraform apply** finishes executing we need to determine if the minions were created correctly. To do this run the following command on the master node and you should see all the unaccepted keys from the minions.
``` bash
~$ sudo salt-key --finger-all
Local Keys:
master.pem:  95:ab:38:67:c4:6c:b8:e0:16:ce:e4:b7:12:f8:ed:6a:2e:34:4b:37:9f:28:a5:ed:3e:4f:86:ed:47:b2:91:e2
master.pub:  b7:dd:0b:71:15:2b:e1:bc:2c:f6:5a:4e:67:0f:da:2e:62:a9:5e:2d:36:48:78:ab:d3:7c:f8:33:61:83:89:f4
Unaccepted Keys:
salt-minion-1.us-central1-c.c.ccfs-igniters-sbx-002.internal:  7b:fe:73:a6:83:50:9a:7d:94:1a:c2:f4:a3:d4:23:b8:e8:88:54:9b:f9:d1:48:01:e1:03:a1:02:14:ec:b4:03
salt-minion-2.us-central1-c.c.ccfs-igniters-sbx-002.internal:  32:c7:b1:99:38:83:66:5d:e5:99:79:1c:36:e7:be:39:2f:57:49:4f:7a:33:8a:ca:a2:de:59:fe:3e:18:62:97
```


Now just accept the connections as follows.
``` bash
~$ sudo salt-key --accept-all
The following keys are going to be accepted:
Unaccepted Keys:
salt-minion-1.us-central1-c.c.ccfs-igniters-sbx-002.internal
salt-minion-2.us-central1-c.c.ccfs-igniters-sbx-002.internal
Proceed? [n/Y] Y
Key for minion salt-minion-1.us-central1-c.c.ccfs-igniters-sbx-002.internal accepted.
Key for minion salt-minion-2.us-central1-c.c.ccfs-igniters-sbx-002.internal accepted.
```

And that's it, you did it!
