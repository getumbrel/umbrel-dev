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

  # Setup VM
  config.vm.define "umbrel-dev"
  config.vm.box = "avi0xff/debian10-arm64"
  config.vm.hostname = "umbrel-dev"
  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"
  config.vm.synced_folder ".", "/vagrant", type: "sshfs", sshfs_opts_append: "-o cache=no"

  # Configure VM resources
  config.vm.provider "parallels" do |parallels|
    parallels.cpus = 2
    parallels.memory = 4096
  end

  # Update package lists
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
  SHELL

  # Install Docker
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get install -y curl python3-pip libffi-dev
    curl -fsSL https://get.docker.com | sudo sh
    sudo usermod -aG docker vagrant
    pip3 install docker-compose
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
    # This is needed to avoid Tor permission issues on startup
    sudo rm -rf ./tor/data/*
    sudo ./scripts/start
  SHELL

  # Message
  config.vm.post_up_message = "#{umbrelLogo}\nUmbrel development environment ready: http://#{config.vm.hostname}.local"
end
