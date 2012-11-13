maintainer       "SecondMarket Labs, LLC"
maintainer_email "systems@secondmarket.com"
license          "Apache 2.0"
description      "Installs/Configures Atlassian Confluence"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{database java mysql postgresql}.each do |d|
  depends d
end

%w{redhat centos}.each do |os|
  supports os
end
