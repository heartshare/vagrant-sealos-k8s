Vagrant.configure("2") do |config|
   (1..3).each do |i|
        config.vm.define "kn#{i}" do |node|
            # 设置虚拟机的Box
            node.vm.box = "centos7.2004_01"

            # 设置虚拟机的主机名
            node.vm.hostname="kn#{i}"

            # [notice]设置虚拟机的默认用户和密码，vagrant ssh登录以此为准，首次启动时需要输入默认密码vagrant
            # node.ssh.username="root"
            # node.ssh.password="root"
            # node.ssh.private_key_path="./keys/id_rsa"
            
            # 设置虚拟机的网络
            node.vm.network "public_network"
            node.vm.network "private_network", ip: "192.168.56.#{100+i}", netmask: "255.255.255.0", gateway: "192.168.56.1"
            
            # 设置主机与虚拟机的共享目录
            # 默认同步当前目录至/vagrant。
            # [bug]视vagrant box版本才可用？
            # node.vm.synced_folder "D:\\", "/home/vagrant/share"

            # VirtaulBox相关配置
            node.vm.provider "virtualbox" do |v|
                # 设置虚拟机的名称
                v.name = "kn#{i}"
                # 设置虚拟机的内存大小
                v.memory = 4096
                # 设置虚拟机的CPU个数
                v.cpus = 2
            end

            config.vm.provision "shell", inline: <<-SHELL
               # 为root配置SSH密钥对
               mkdir /root/.ssh/ -p
               chmod 700 /root/.ssh/
               cd /root/.ssh/

               cp /vagrant/keys/id_rsa . -rf
               chmod 600 ./id_rsa
               
               cp /vagrant/keys/authorized_keys . -rf
               chmod 600 ./authorized_keys

               # 为vagrant用户配置公钥
               # cp /vagrant/keys/authorized_keys /root/.ssh/ -rf
            SHELL
        end
   end
end