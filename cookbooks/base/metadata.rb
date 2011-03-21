maintainer       "gilles"
maintainer_email "gilles.devaux@gmail.com"
license          "All rights reserved"
description      "Installs/Configures base"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

%w{git}.each do |dep|
  depends dep
end
