# Kubernetes Cluster Management


## Cluster Hardware and Infrastructure

### Cluster Nodes

One exmaple of a cluster of commodity of-the-shelf hardware is shown below. This version consists of 7 nodes.

| Host                 | CPU Clock | CPU Model                  | # of Cores | Memory | Storage | Storage Interface | Network Standard | Network Bandwidth | Operating System  | Linux Distribution   |
|----------------------|-----------|----------------------------|------------|--------|---------|-------------------|------------------|-------------------|-------------------|----------------------|
| open6gnet-testbed    | 2.80GHz   | Intel(R) Core(TM) i7-6700T | 4          | 32G    | 512G    | SATA 3            | Ethernet         | 10000M/s          | Linux 5.15.0-122  | Ubuntu 22.04.31DS    |
| ds1-node2            | 2.80GHz   | Intel(R) Core(TM) i7-6700T | 4          | 32G    | 512G    | SATA 3            | Ethernet         | 10000M/s          | Linux 5.15.0-117  | Ubuntu 22.04.31DS    |
| ds2-node3            | 2.90GHz   | Intel(R) Core(TM) i7-7700T | 4          | 32G    |         |                   | Ethernet         | 10000M/s          | Linux 6.2.0-39    | Ubuntu 23.04         |
| core1-node4          | 2.80GHz   | Intel(R) Core(TM) i7-6700T | 4          | 16G    | 512G    | SATA 3            | Ethernet         | 10000M/s          | Linux 5.15.0-117  | Ubuntu 22.04.31DS    |
| core2-node5          | 2.80GHz   | Intel(R) Core(TM) i7-6700T | 4          | 32G    | 512G    | SATA 3            | Ethernet         | 10000M/s          | Linux 5.15.0-177  | Ubuntu 22.04.31DS    |
| ran1-node6           | 2.80GHz   | Intel(R) Core(TM) i5-7400T | 2          | 8G     | 1T      | SATA 3            | Ethernet         | 10000M/s          | Linux 5.15.0-117  | Ubuntu 22.04.31DS    |
| ran2-node7           | 2.80GHz   | Intel(R) Core(TM) i7-6700T | 4          | 8G     | 256G    | SATA 3            | Ethernet         | 10000M/s          | Linux 5.15.0-117  | Ubuntu 22.04.31DS    |


### Cluster Network

The simplest versino of the cluster has a start topology with the **open6gnet-testbed** host as a gateway.

| Hostname           | Kubernetes Control Network IP | External Network IP | N6 VLAN | N3 VLAN | Gateway       |
|--------------------|-------------------------------|---------------------|---------|---------|---------------|
| open6gnet-testbed  | 10.123.123.1                  | 192.168.143.4       | -       | -       | 192.168.143.1 |
| dn1-node2          | 10.123.123.2                  | -                   | -       | -       | 10.123.123.1  |
| dn2-node3          | 10.123.123.3                  | -                   | -       | -       | 10.123.123.1  |
| core1-node4        | 10.123.123.4                  | -                   | -       | -       | 10.123.123.1  |
| core2-node5        | 10.123.123.5                  | -                   | -       | -       | 10.123.123.1  |
| ran1-node6         | 10.123.123.6                  | -                   | -       | -       | 10.123.123.1  |
| ran2-node7         | 10.123.123.7                  | -                   | -       | -       | 10.123.123.1  |


## Microk8s Cluster  Management

### Installing the Operating System

- Install Ubuntu 22.04 in all nodes.
- Configure the nework interfaces to the correct IP addresses as shwon in the table above.
- Check the network connectivity between the nodes.

### Update hosts file

- Update the **/etc/hosts** file in the open6gnet-testbed host.

```bash
sudo nano /etc/hosts
```

- Insert the following lines.

```bash
dn1-node2 10.123.123.2
dn2-node3 10.123.123.3
core1-node4 10.123.123.4
core2-node5 10.123.123.5
ran1-node6 10.123.123.6
ran2-node7  10.123.123.7
```

- Update the **/etc/hosts** file in all nodes.


### Configure passwordless SSH access

- Generate a new SSH key pair in the **open6gnet-testbed** host.

```bash
ssh-keygen -t rsa -b 4096 -C "open6gnet-testbed"
```


- Copy the public key to all nodes.

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub dn1-node2
ssh-copy-id -i ~/.ssh/id_rsa.pub dn2-node3
ssh-copy-id -i ~/.ssh/id_rsa.pub core1-node4
ssh-copy-id -i ~/.ssh/id_rsa.pub core2-node5
ssh-copy-id -i ~/.ssh/id_rsa.pub ran1-node6
ssh-copy-id -i ~/.ssh/id_rsa.pub ran2-node7
```

### Clone the k8s-cluster-mgmt repository

- Install Ansible in the **open6gnet-testbed** host.

```bash
sudo apt update
sudo apt install ansible
```
    
- On the **open6gnet-testbed** host, clone the repository.

```bash
git clone https://github.com/msbphd/k8s-cluster-mgmt.git
```

### Prepare the Ansible Inventory

- Check the **k8s-cluster-mgmt/ansible/inventory.ini** file and update the IP addresses of the nodes if necessary.
- Using ansible, check the connectivity between the nodes.

```bash 
ansible -i k8s-cluster-mgmt/ansible/inventory.ini -m ping all
```

### Setup the Microk8s Cluster


- Change to the ansible directory.

```bash
cd k8s-cluster-mgmt/ansible
```

- Run the ansible playbook to setup the Microk8s cluster.

```bash
ansible-playbook -i inventory.ini open6gnet-cluster-init.yml
```

- Check the status of the Microk8s cluster.

```bash
microk8s kubectl get nodes
```

- You should see the list of nodes in the cluster.
- If you see the nodes, the cluster is ready to use.

