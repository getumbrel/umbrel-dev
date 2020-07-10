umbrelLogo = <<-TEXT
              ,;###GGGGGGGGGGl#Sp
           ,##GGGlW""^'  '`""%GGGG#S,
         ,#GGG"                  "lGG#o
        #GGl^                      '$GG#
      ,#GGb                          \GGG,
      lGG"                            "GGG
     #GGGlGGGl##p,,p##lGGl##p,,p###ll##GGGG
    !GGGlW"""*GGGGGGG#""""WlGGGGG#W""*WGGGGS
     ""          "^          '"          ""


                @GGS         lG#
                !GGG        !GGG
                !GGG        !GGG
                !GGG        !GGG
                !GGG        !GGG
                !GGG        !GGG
                'GGG        $GGl
                 "GGG#psqp##GG#
                   "%GGGGGG#"
TEXT

Vagrant.configure(2) do |config|
  config.vm.box = "debian/buster64"
  config.vm.hostname = "umbrel-dev"
  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"

  # Configure similar specs to a Raspberry Pi
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # Provision Docker
  config.vagrant.plugins = "vagrant-docker-compose"
  config.vm.provision :docker
  config.vm.provision :docker_compose

  # Update package lists
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
  SHELL

  # Install Umbrel
  config.vm.provision "shell", inline: <<-SHELL
    apt-get install -y git
    cd /vagrant/getumbrel/umbrel
    REGTEST=1 ./configure-box.sh
    sudo chown -R 1000:1000 lnd/ bitcoin/
    sed -i 's/umbrel.local/#{config.vm.hostname}.local/g' docker-compose.yml
  SHELL

  # Install Avahi
  config.vm.provision "shell", inline: <<-SHELL
    apt-get install -y avahi-daemon avahi-discover libnss-mdns
  SHELL

  # Message
  config.vm.post_up_message = "#{umbrelLogo}\nUmbrel development environment ready: http://#{config.vm.hostname}.local"
end
