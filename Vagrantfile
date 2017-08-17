required_plugins = ["vagrant-hostsupdater", "vagrant-berkshelf"]
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure("2") do |config|

  config.vm.define "web" do |web| 
    web.vm.box = "ubuntu/xenial64"
    web.vm.network "private_network", ip: "192.168.10.100"
    web.hostsupdater.aliases = ["development.local"]
    web.vm.synced_folder ".", "/home/ubuntu/app"

    web.vm.provision "chef_solo" do |chef|
      chef.run_list = ['recipe[node-server::default]']
    end
    web.vm.provision "shell", inline: "echo 'export DB_HOST=mongodb://192.168.10.101/test' >> .bash_profile"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.101"
    db.hostsupdater.aliases = ["db.local"]
    db.vm.synced_folder "./box_db", "/home/ubuntu/app/box_db"

    db.vm.provision "chef_solo" do |chef|
      chef.run_list = ['recipe[mongo::default]']
    end

  end

end