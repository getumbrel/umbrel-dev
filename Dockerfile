FROM debian:buster-slim

# Update package lists
RUN apt-get update

# Install Vagrant
RUN apt-get install -y curl
RUN curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
RUN apt-get install ./vagrant_2.2.6_x86_64.deb

# Install vagrant-libvirt
RUN apt-get install -y qemu qemu-utils libvirt-daemon-system libvirt-clients ebtables dnsmasq-base
RUN apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev build-essential
RUN vagrant plugin install vagrant-libvirt

# Test vagrant up
RUN vagrant box add --provider libvirt debian/buster64
RUN echo '\n\
Vagrant.configure(2) do |config|\n\
  config.vm.box = "debian/buster64"\n\
  config.vm.provider :libvirt do |libvirt|\n\
    libvirt.driver = "qemu"\n\
  end\n\
end\n\
' > Vagrantfile
RUN libvirtd --daemon && vagrant up --provider=libvirt
