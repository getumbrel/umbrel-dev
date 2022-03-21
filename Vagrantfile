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
  # Define VM compute resources
  CORES = ENV.key?("UMBREL_DEV_CORES") ? ENV["UMBREL_DEV_CORES"] : 4
  MEMORY = ENV.key?("UMBREL_DEV_MEMORY") ? ENV["UMBREL_DEV_MEMORY"] : 4096

  # Setup VM
  config.vm.define "umbrel-dev"
  config.vm.box = ENV.key?("ARCH") and ENV["ARCH"].include?("arm") ? "avi0xff/debian10-arm64" : "debian/buster64"
  config.vm.hostname = "umbrel-dev"
  config.vm.network "public_network", bridge: "en0: Wi-Fi"
  # Private network needed for NFS share
  config.vm.network "private_network", ip: "192.168.56.56"

  # Disable sync of default vagrant folder
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Mount source into /code and use bindfs to re-map to /vagrant with correct ownership
  # To resolve this error: uninitialized constant VagrantPlugins::HostDarwin::Cap::Version (NameError)
  # sudo curl -o /opt/vagrant/embedded/gems/2.2.19/gems/vagrant-2.2.19/plugins/hosts/darwin/cap/path.rb https://raw.githubusercontent.com/hashicorp/vagrant/42db2569e32a69e604634462b633bb14ca20709a/plugins/hosts/darwin/cap/path.rb 
  config.vm.synced_folder ".", "/code", type: "nfs"

  # Bindfs config.
  config.bindfs.force_empty_mountpoints = true
  config.bindfs.default_options = {
    force_user: 'vagrant',
    force_group: 'vagrant',
    # Everything is owned by vagrant:vagrant and Umbrel will chown from time to time
    # Causing an operation not permitted error, this ignores that error
    o: 'chown-ignore'
  }
  config.bindfs.bind_folder "/code", "/vagrant"

  # VirtualBox config.
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpus", CORES]
    vb.customize ["modifyvm", :id, "--memory", MEMORY]
  end

  # Parallels config.
  config.vm.provider "parallels" do |parallels|
    parallels.cpus = CORES
    parallels.memory = MEMORY
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
    ./scripts/start
  SHELL

  # Message
  config.vm.post_up_message = "#{umbrelLogo}\nUmbrel development environment ready: http://#{config.vm.hostname}.local"
end
