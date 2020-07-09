Vagrant.configure(2) do |config|
  config.vm.box = "debian/buster64"
  config.vm.hostname = "umbrel"
  config.vm.network "public_network"

  # Configure similar specs to a Raspberry Pi
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # Provision Docker
  config.vagrant.plugins = "vagrant-docker-compose"
  config.vm.provision :docker
  config.vm.provision :docker_compose

  # Setup script
  config.vm.provision "shell", inline: <<-SHELL
    # Install Umbrel
    apt-get update
    apt-get install -y git
    curl "https://raw.githubusercontent.com/getumbrel/umbrel/v0.1.3-beta/install-box.sh" | sh
    REGTEST=1 ./configure-box.sh
    sudo chown -R 1000:1000 lnd/ bitcoin/

    # Install Avahi
    apt-get install -y avahi-daemon avahi-discover libnss-mdns
  SHELL

  # Message
  config.vm.post_up_message = "Umbrel dev environment ready!"
end
