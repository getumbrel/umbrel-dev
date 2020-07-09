Vagrant.configure(2) do |config|
  config.vm.box = "debian/buster64"
  config.vm.hostname = "umbrel"

  # Configure similar specs to a Raspberry Pi
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end
end
