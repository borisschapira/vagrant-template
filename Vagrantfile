# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  ## Choose your base box, not necessarily this one
  config.vm.box = "precise-server-amd64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

  ## Variables for NFS
  _not_windows = RUBY_PLATFORM =~ /darwin/ || RUBY_PLATFORM =~ /linux/
  _nfs_setting = RUBY_PLATFORM =~ /darwin/ || RUBY_PLATFORM =~ /linux/ || Vagrant.has_plugin?("vagrant-winnfsd")

  @sync_folders = Array.new

  ## Provisioning folders
  @sync_folders.push({
    "from"=>"salt/roots/",
    "to"=>"/srv/"
    });

  @sync_folders.push({
    "from"=>"salt/roots/salt/apache2/html-default",
    "to"=>"/var/www/html/default/"
    });
  ## / Provisioning folders

  ## Projects folders
  @sync_folders.push({
    "from"=>"projects/project1/",
    "to"=>"/var/www/project1/"
    });

  @sync_folders.push({
    "from"=>"projects/otherProjects/otherProject1/",
    "to"=>"/var/www/otherProject1/"
    });

  @sync_folders.push({
    "from"=>"projects/project2/",
    "to"=>"/var/www/project2/"
    });

  @sync_folders.push({
    "from"=>"projects/project3/",
    "to"=>"/var/www/project3/"
    });

  @sync_folders.push({
    "from"=>"projects/otherProjects/otherProject2/",
    "to"=>"/var/www/otherProject2/"
    });
  ## / projects folders

  ## Filter on folder that really exists
  ## for example, projects/project3/ doest not exist
  @sync_folders.select! { |a| Dir.exists?(a["from"]) }

  # Reorder folders for winnfsd plugin compatilibty
  # see https://github.com/GM-Alex/vagrant-winnfsd/issues/12#issuecomment-78195957
  @sync_folders.sort! { |a,b| a["from"].length <=> b["from"].length }

  @sync_folders.each do |project|
    config.vm.synced_folder project["from"], project["to"],
    :nfs => _nfs_setting,
    mount_options:['nolock,vers=3,udp,noatime,actimeo=1']
  end

  # Network
  _vm_ip = "10.0.0.157"
  _vm_name = "vagrant-template"
  config.vm.network :private_network, ip: _vm_ip
  config.vm.network :public_network
  config.vm.hostname = _vm_name + ".lan"

  if _not_windows
    if Vagrant.has_plugin?("vagrant-hostsupdater")
      config.hostsupdater.aliases = [
        config.vm.hostname,
        'project1.' + config.vm.hostname,
        'project2.' + config.vm.hostname
      ]
      config.hostsupdater.remove_on_suspend = true
    else
      puts 'You should install vagrant-hostsupdater plugin for automatic hosts update'
    end
  else
    puts 'You should add the following matching to your host :'
    puts _vm_ip + ' ' + config.vm.hostname
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/.", "1"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", 2048]
    vb.customize ["modifyvm", :id, "--name", _vm_name]
  end

  ## Set your salt configs here
  config.vm.provision :salt do |salt|

    ## Minion config is set to ``file_client: local`` for masterless
    salt.minion_config = "salt/minion"

    ## Installs our example formula in "salt/roots/salt"
    salt.run_highstate = true

    salt.verbose = true

  end
end