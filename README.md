# Notice
This project has moved to a new repo [Azure Diagnostics Tools](https://github.com/Azure/azure-diagnostics-tools/tree/master/Logstash/logstash-input-azurewadtable)

Check there for updates.

This plugin is a part of [Microsoft Azure Diagnostics with ELK](https://github.com/mspnp/semantic-logging/tree/v3/ELK).

[See more documentation.](https://github.com/mspnp/semantic-logging/blob/v3/ELK/md/LogstashExtensions.md#azure-wad-table)

# Installing Logstash and this plugin on Ubuntu

You can run this script found in this repo.
```
    ./ubuntu-wad-logstash-install.sh
```

This is what the script will do at a high level.
0. Install some utilities
1. Install Java
2. Install Logstash
3. Install Plugin

# Setting up your Development Environment
This is how I set up my environment when I work on Logstash plugins. This is mostly so I don't forget how to do this in the future, but if you're interested have at it.

TL;DR:
1. Setup some sort of Linux environment you can use to test stuff with.
0. Install some utilities
1. Install Java
2. Install RVM
3. Install JRuby
4. Install Logstash
5. Clone the repo

First and foremost I do most of my development on a Windows PC. So tools like Vagrant are invaluable for prototyping
Linux environments. For OSX you can use Parallels and host an Ubuntu machine. (Also this will mostly be geared towards how to
set up a Windows machine for development since I'm not using a Mac for this stuff at the moment.)

## Unix environment on Windows
I personally get away with using Git Bash that gets installed when you install git-scm. Seems to work fine for me. You have to
run the prompt in admin mode when using Vagrant.

## Setting up Vagrant
Start off by installing vagrant using the normal installer. In Vagrant there are two things you need to know. There are things
called boxes which you can think of as os-images and then providers. You host a box on a provider essentially. Since I am on
Windows I prefer to use the hyperv provider. (Less things to install, I'm sure everything else will work fine as well)

If you want to go down the HyperV route, make sure to enable hyper-v on your machine. Both of these instructions involve a restart.

After you have restarted create a clean directory and navigate to it. Run this command
```
vagrant init hashicorp/precise64 
```

This will create a Vagrantfile. For Windows 10 you will likely need to do some extra work to get shared folders to work. 
```
 config.vm.synced_folder ".", "/vagrant", type: "smb", smb_username: "<Local account name>", smb_password: "<Local account password>"
```
I recommend creating a new local account for the above config. Make sure to replace `<Local account name>` and `<Local account password>`. (Also don't forget
this account will need access to the folder you are doing your work in.

Once this is set up simply run:
```
vagrant up --provider hyperv
vagrant ssh
```

This will let you ssh into the machine. Navigate to /vagrant (`cd /vagrant`). This is the shared folder between the windows file system and the Ubuntu VM.

Clone the repo to this directory. You can do all your edits on the Windows side (if you so choose, remember that Windows has different line endings so you'll need to run dos2unix if you go this route).
Or if you want to do it ubuntu you can do as well. I like to keep things in this folder so that when I come back to this environment I know what I was working on without having to start the VM.

Once you have a VM, you'll need to install a bunch of dependencies to get going. I'll list them out (I will likely write a script for this as well):

Java, RVM (This is ruby env manager), Jruby (Install this through RVM), Logstash. 

Below are more instructions on how to actually run a plugin locally, but this should be enough to get going.

# Logstash Plugin
`The following is default documentation when you create a new plugin. Left as notes.`

This is a plugin for [Logstash](https://github.com/elasticsearch/logstash).

It is fully free and fully open source. The license is Apache 2.0, meaning you are pretty much free to use it however you want in whatever way.

## Documentation

Logstash provides infrastructure to automatically generate documentation for this plugin. We use the asciidoc format to write documentation so any comments in the source code will be first converted into asciidoc and then into html. All plugin documentation are placed under one [central location](http://www.elasticsearch.org/guide/en/logstash/current/).

- For formatting code or config example, you can use the asciidoc `[source,ruby]` directive
- For more asciidoc formatting tips, see the excellent reference here https://github.com/elasticsearch/docs#asciidoc-guide

## Need Help?

Need help? Try #logstash on freenode IRC or the https://discuss.elastic.co/c/logstash discussion forum.

## Developing

### 1. Plugin Developement and Testing

#### Code
- To get started, you'll need JRuby with the Bundler gem installed.

- Create a new plugin or clone and existing from the GitHub [logstash-plugins](https://github.com/logstash-plugins) organization. We also provide [example plugins](https://github.com/logstash-plugins?query=example).

- Install dependencies
```sh
bundle install
```

#### Test

- Update your dependencies

```sh
bundle install
```

- Run tests

```sh
bundle exec rspec
```

### 2. Running your unpublished Plugin in Logstash

#### 2.1 Run in a local Logstash clone

- Edit Logstash `Gemfile` and add the local plugin path, for example:
```ruby
gem "logstash-filter-awesome", :path => "/your/local/logstash-filter-awesome"
```
- Install plugin
```sh
bin/plugin install --no-verify
```
- Run Logstash with your plugin
```sh
bin/logstash -e 'filter {awesome {}}'
```
At this point any modifications to the plugin code will be applied to this local Logstash setup. After modifying the plugin, simply rerun Logstash.

#### 2.2 Run in an installed Logstash

You can use the same **2.1** method to run your plugin in an installed Logstash by editing its `Gemfile` and pointing the `:path` to your local plugin development directory or you can build the gem and install it using:

- Build your plugin gem
```sh
gem build logstash-filter-awesome.gemspec
```
- Install the plugin from the Logstash home
```sh
bin/plugin install /your/local/plugin/logstash-filter-awesome.gem
```
- Start Logstash and proceed to test the plugin

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, complaints, and even something you drew up on a napkin.

Programming is not a required skill. Whatever you've seen about open source and maintainers or community members  saying "send patches or die" - you will not see that here.

It is more important to the community that you are able to contribute.

For more information about contributing, see the [CONTRIBUTING](https://github.com/elasticsearch/logstash/blob/master/CONTRIBUTING.md) file.
