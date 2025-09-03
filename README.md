

# create from blueprint

```
./cluster-toolkit/gcluster deploy blueprint.yaml
```


# delete the cluster

assuming the cluster was created in the `hpc-slurm` directory:

```
./cluster-toolkit/gcluster delete hpc-slurm
```


# passwordless ssh across nodes

assuming your homedirs are mounted on every node, users can log into the login node using Compute OS Login and use the following to enable passwordless ssh across nodes from the login node.

first ssh into the login node

```
gcloud compute ssh hpcslurm-slurm-login-001 --zone us-central1-b
```

create an SSH key
``` 
ssh-keygen -t rsa
```

copy public key it into `.ssh/authorized_keys` and set the right permissions

```
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
chmod 0600 .ssh/authorized_keys
```

now test whether passwordless SSH works on the controller node

```
ssh hpcslurm-controller
```


Note that if you delete and re-create the cluster, or if you use dynamic nodes you may get messages like this when host fingerprints change, e.g. for `hpcslurm-controller`.  This is because the host's SSH key is saved in your home directory in `~/.ssh/known_hosts` to prevent host spoofing / man-in-the-middle attacks.

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@       WARNING: POSSIBLE DNS SPOOFING DETECTED!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
The ECDSA host key for hpcslurm-controller has changed,
and the key for the corresponding IP address 10.32.0.8
is unknown. This could either mean that
DNS SPOOFING is happening or the IP address for the host
and its host key have changed at the same time.
```

if you're sure that the host has changed and no one is trying to trick you, you can remove the saved host key and force SSH to re-scan the key, e.g. for `hpcslurm-controller`:

```
ssh-keygen -R hpcslurm-controller
```

then try to SSH again, and save the new key in `known_hosts`.