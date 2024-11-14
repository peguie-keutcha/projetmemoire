#variable
IMAGE_NAME = "almalinux/8"   # Image to use
MEM = 2048                       # Amount of RAM
CPU = 2                             # Number of processors (Minimum value of 2 otherwise it will not work)
NODE_IP1 = "192.168.108.50"    # First three octets of the IP address that will be assign to all type of nodes
MASTER_IP = "192.168.108.51" 
ANSIBLE_IP = "192.168.108.52" 
NODE_IP2 = "192.168.108.53"
PROMETHEUS_IP = "192.168.108.54" # IP for server-prometheus

Vagrant.configure("2") do |config|
 
    # Configuration de l'OS 
    config.vm.box = IMAGE_NAME

    #Configuration master kube 
    config.vm.define "master" do |master|
    master.vm.hostname = "master-node"
    master.vm.network "private_network", ip: MASTER_IP
    master.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.vmx["displayName"] = "MASTER-NODE"
      v.vmx["numvcpus"] = CPU
      v.vmx["memsize"] = MEM
    end

  # Création du user master-jenkins 
    master.vm.provision "shell", inline: <<-SHELL
    # Création variable mot de passe crypté 
      PASSWORD=$(openssl passwd -6 azerty11)
    # Création user avec mot de passe 
      sudo useradd -m -p "$PASSWORD" master-jenkins 
    # Ajout droits sudo + droits sudo sans mot de pase  
      sudo usermod -aG wheel master-jenkins 
      echo 'master-jenkins   ALL=(ALL) NOPASSWD:ALL'  | sudo tee /etc/sudoers.d/master-jenkins 

    # S'assurer que la conf sshd_config permet la réception de clé 
      sudo sed -i 's/^nameserver .*/nameserver 8.8.8.8/' /etc/resolv.conf
      sudo sed -i '/^#.*PubkeyAuthentication/s/^#//' /etc/ssh/sshd_config
      sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/^ChallengeResponseAuthentication.*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL
    end
    #Configuration agent-jenkins 
    config.vm.define "worker" do |worker|
    worker.vm.hostname = "agent-jenkins"
    worker.vm.network "private_network", ip: NODE_IP1
    worker.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.vmx["displayName"] = "AGENT-JENKINS"
      v.vmx["numvcpus"] = CPU
      v.vmx["memsize"] = MEM
    end
    # Création du user agent-jenkins 
    worker.vm.provision "shell", inline: <<-SHELL
    # Création variable mot de passe crypté 
      PASSWORD=$(openssl passwd -6 azerty11)
    # Création user avec mot de passe 
      sudo useradd -m -p "$PASSWORD" agent-jenkins
    # Ajout droits sudo + droits sudo sans mot de pase  
      sudo usermod -aG wheel agent-jenkins
      echo 'agent-jenkins  ALL=(ALL) NOPASSWD:ALL'  | sudo tee /etc/sudoers.d/agent-jenkins
 
    # S'assurer que la conf sshd_config permet la réception de clé  et modifier le résolveur 
      sudo sed -i 's/^nameserver .*/nameserver 8.8.8.8/' /etc/resolv.conf
      sudo sed -i '/^#.*PubkeyAuthentication/s/^#//' /etc/ssh/sshd_config
      sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/^ChallengeResponseAuthentication.*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL
    end

    # Configuration agent-jenkins2 (nouveau)
    config.vm.define "worker2" do |worker2|
    worker2.vm.hostname = "agent-jenkins2"
    worker2.vm.network "private_network", ip: NODE_IP2
    worker2.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.vmx["displayName"] = "AGENT-JENKINS2"
      v.vmx["numvcpus"] = CPU
      v.vmx["memsize"] = MEM
    end

    # Création du user agent-jenkins2
    worker2.vm.provision "shell", inline: <<-SHELL
      PASSWORD=$(openssl passwd -6 azerty11)
      sudo useradd -m -p "$PASSWORD" agent-jenkins2
      sudo usermod -aG wheel agent-jenkins2
      echo 'agent-jenkins2  ALL=(ALL) NOPASSWD:ALL'  | sudo tee /etc/sudoers.d/agent-jenkins2
      sudo sed -i 's/^nameserver .*/nameserver 8.8.8.8/' /etc/resolv.conf
      sudo sed -i '/^#.*PubkeyAuthentication/s/^#//' /etc/ssh/sshd_config
      sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/^ChallengeResponseAuthentication.*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL
  end

    # Configuration du serveur Prometheus
    config.vm.define "server-prometheus" do |prometheus|
    prometheus.vm.hostname = "server-prometheus"
    prometheus.vm.network "private_network", ip: PROMETHEUS_IP
    prometheus.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.vmx["displayName"] = "SERVER-PROMETHEUS"
      v.vmx["numvcpus"] = CPU
      v.vmx["memsize"] = MEM
    end

    # Création du user prometheus
    prometheus.vm.provision "shell", inline: <<-SHELL
      PASSWORD=$(openssl passwd -6 azerty11)
      sudo useradd -m -p "$PASSWORD" prometheus
      sudo usermod -aG wheel prometheus
      echo 'prometheus  ALL=(ALL) NOPASSWD:ALL'  | sudo tee /etc/sudoers.d/prometheus
      sudo sed -i 's/^nameserver .*/nameserver 8.8.8.8/' /etc/resolv.conf
      sudo sed -i '/^#.*PubkeyAuthentication/s/^#//' /etc/ssh/sshd_config
      sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/^ChallengeResponseAuthentication.*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL
  end



    #Configuration serveur ansible
    config.vm.define "ansible" do |ansible|
    ansible.vm.hostname = "ansible"
    ansible.vm.network "private_network", ip: ANSIBLE_IP
    ansible.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.vmx["displayName"] = "ANSIBLE"
      v.vmx["numvcpus"] = CPU
      v.vmx["memsize"] = MEM
    end
    ansible.vm.provision "shell", inline: <<-SHELL
    # Modifier le resolveur 
      sudo sudo sed -i 's/^nameserver .*/nameserver 8.8.8.8/' /etc/resolv.conf
    # Création variable mot de passe crypté 
      PASSWORD=$(openssl passwd -6 azerty11)
    # Création user avec mot de passe 
      sudo useradd -m -p "$PASSWORD" ansible
    # Ajout droits sudo + droits sudo sans mot de pase  
      sudo usermod -aG wheel ansible
      echo 'ansible  ALL=(ALL) NOPASSWD:ALL'  | sudo tee /etc/sudoers.d/ansible
    # Installer ansible 
      sudo dnf install -y epel-release
      sudo dnf install -y ansible

    # Générer les clé ssh EN TANT QU'ANSIBLE !!!
      sudo -u ansible ssh-keygen -t rsa -N "" -f /home/ansible/.ssh/id_rsa

    # Envoyer la clé aux machines cliente ansible 
      sudo -u ansible sshpass -p "azerty11" ssh-copy-id -o StrictHostKeyChecking=no master-jenkins @192.168.108.51
      sudo -u ansible sshpass -p "azerty11" ssh-copy-id -o StrictHostKeyChecking=no agent-jenkins@192.168.108.50
      sudo -u ansible sshpass -p "azerty11" ssh-copy-id -o StrictHostKeyChecking=no agent-jenkins2@192.168.108.53
      sudo -u ansible sshpass -p "azerty11" ssh-copy-id -o StrictHostKeyChecking=no prometheus@192.168.108.54
      SHELL
end

end

 

    

      
