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
  # Install required plugins
  config.vagrant.plugins = {"vagrant-vbguest" => {"version" => "0.24.0"}}

  # Setup VM
  config.vm.define "umbrel-dev"
  config.vm.box = "debian/buster64"
  config.vm.hostname = "umbrel-dev"
  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # Configure similar specs to a Raspberry Pi
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end

  # Update package lists
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
  SHELL

  # Install Docker
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get install -y curl
    curl -fsSL https://get.docker.com | sudo sh
    sudo usermod -aG docker vagrant
    sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  SHELL

  # Install Avahi
  config.vm.provision "shell", inline: <<-SHELL
    apt-get install -y avahi-daemon avahi-discover libnss-mdns
  SHELL

  # Install Umbrel
  config.vm.provision "shell", inline: <<-SHELL
    apt-get install -y fswatch rsync jq
    cd /vagrant/getumbrel/umbrel
    sudo NETWORK=regtest ./scripts/configure
    docker-compose build --parallel
    docker-compose run dashboard -c yarn
  SHELL

  # Start Umbrel on boot
  config.vm.provision "shell", run: 'always', inline: <<-SHELL
    cd /vagrant/getumbrel/umbrel
    sudo chown -R 1000:1000 .
    chmod -R 700 tor/data/*
    ./scripts/start
  SHELL

  # Message
  config.vm.post_up_message = "#{umbrelLogo}\nUmbrel development environment ready: http://#{config.vm.hostname}.local"
end
