

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
