# Ansible Playbooks for Kubernetes Cluster Deployment

This repository contains Ansible playbooks to automate the deployment of a Kubernetes cluster.

## Prerequisites

* **Ansible:** Installed on your control machine. 
* **Target Machines:** 
    * Accessible via SSH.
    * Proper network configuration (e.g., static IPs, hostname resolution).
* **Inventory File:** Define your target machines in the `hosts` file.

## Deployment Steps

1. **Configure Target Machines:** Ensure your target machines meet the prerequisites.
2. **Update Inventory:** Define your master and worker nodes in the `hosts` file.
3. **Customize Environment Variables:**  Adjust settings in the `playbooks/env_variables` file as needed.
4. **Run the Playbook:** 

```bash
    ansible-playbook -i hosts playbooks/settingup_k8s_cluster.yaml
    ansible-playbook -i hosts playbooks/config_master_node.yaml
    ansible-playbook -i hosts playbooks/config_worker_node.yaml
```

## Verify Deployment
1. Check nodes status `kubectl get nodes`
2. Deploy a Test pod 
```bash
    kubectl run nginx --image=nginx --labels="app=nginx"
    kubectl get pods 
```
if everything is OK, you can see information like this 
```bash
    NAME    READY   STATUS    RESTARTS   AGE
    nginx   1/1     Running   0          18s
```

