resource "proxmox_vm_qemu" "cloudinit-k3s-master" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "pve"
    desc = "Cloudinit Ubuntu"
    count = 2
    onboot = true

    # The template name to clone this vm from
    clone = "ubuntu-cloud"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    numa = false
    vcpus = 0
    cpu_type = "host"
    memory = 4096
    name = "k3s-master-0${count.index+1}"

    scsihw   = "virtio-scsi-pci" 
    bootdisk = "scsi0"


    disks {
        ide {
            ide2 {
                cloudinit {
                  storage = "local-lvm"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                  storage = "local-lvm"
                  size = 12
                }
            }
        }
    }

    network {
      id = 0
      model = "virtio"
      bridge = "vmbr0"
    }

    ipconfig0 = "ip=192.168.10.11${count.index + 1}/24,gw=192.168.10.1"
    ciuser = "ubuntu"
    cipassword = "20072003"
    sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMODqKBXJbH+YIqYiKXgbFHsImLcMfxDki6tqbf4kYjZ minhbui@PC1
    EOF

    serial {
        id = 0
        type = "socket"
    }

    vga {
        type = "serial0"
    }
}

resource "proxmox_vm_qemu" "cloudinit-k3s-worker" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "pve"
    desc = "Cloudinit Ubuntu"
    count = 3
    onboot = true

    # The template name to clone this vm from
    clone = "ubuntu-cloud"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 2
    sockets = 1
    numa = false
    vcpus = 0
    cpu_type = "host"
    memory = 2048
    name = "k3s-worker-0${count.index+1}"

    scsihw   = "virtio-scsi-pci" 
    bootdisk = "scsi0"


    disks {
        ide {
            ide2 {
                cloudinit {
                  storage = "local-lvm"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                  storage = "local-lvm"
                  size = 12
                }
            }
        }
    }

    network {
      id = 0
      model = "virtio"
      bridge = "vmbr0"
    }

    ipconfig0 = "ip=192.168.10.12${count.index + 1}/24,gw=192.168.10.1"
    ciuser = "ubuntu"
    cipassword = "20072003"
    sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMODqKBXJbH+YIqYiKXgbFHsImLcMfxDki6tqbf4kYjZ minhbui@PC1
    EOF

    serial {
        id = 0
        type = "socket"
    }

    vga {
        type = "serial0"
    }
}