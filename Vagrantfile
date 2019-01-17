Vagrant.configure(2) do |c|
    ubuntu_version = "ubuntu/bionic64"
    vm_memory_mb = "2048"
    shared_folder_host = "./"
    shared_folder_guest = "/home/vagrant/shared"
    ips = ["172.28.128.101", "172.28.128.102", "172.28.128.103", "172.28.128.104", "172.28.128.105"]
    num_vms = 1

    (1..num_vms).each do |i|
        vm_name = "es#{(i)}"
        c.vm.define vm_name do |es|
            es.vm.box = ubuntu_version
            es.vm.hostname = "#{vm_name}-sandbox"
            es.vm.synced_folder shared_folder_host, shared_folder_guest, create: true,
                :mount_options => ['dmode=777', 'fmode=777']
            es.vm.network "private_network", ip: ips[i-1]
            es.vm.provider "virtualbox" do |v|
                v.memory = vm_memory_mb
                v.customize ["modifyvm", :id, "--nicpromisc1", "allow-all"]
            end
            es.vm.provision "shell", path: "es_provision.sh"
        end
    end

    
    
end
