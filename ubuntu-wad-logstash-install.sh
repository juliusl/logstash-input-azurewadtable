#!/bin/bash
#
# ========================================================================================
# Microsoft patterns & practices (http://microsoft.com/practices)
# SEMANTIC LOGGING APPLICATION BLOCK
# ========================================================================================
#
# Copyright (c) Microsoft.  All rights reserved.
# Microsoft would like to thank its contributors, a list
# of whom are at http://aka.ms/entlib-contributors
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License. You may
# obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing permissions
# and limitations under the License.
#
help()
{
    echo ""
    echo ""
	echo "This script installs Java, Logstash, and the Azure WAD plugin"
	echo "Currently requires no parameters"
	echo ""
	echo ""
}

log()
{
	echo "$1"
}

# Install Utilities
log "Installing utilities." 
sudo apt-get update
sudo apt-get -y --force-yes install python-software-properties debconf-utils

# Install Java
log "Installing Java." 
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y --force-yes oracle-java8-installer

# Install Logstash
log "Installing Logstash."
echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash-2.2.x.list
sudo apt-get update
sudo apt-get -y --force-yes install logstash

# Install Azure Plugin
log "Installing Azure WAD Table Plugin"
sudo /opt/logstash/bin/plugin install logstash-input-azurewadtable

log "Complete"

