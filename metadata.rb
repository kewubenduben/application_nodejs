maintainer       "Conrad Kramer"
maintainer_email "conrad@kramerapps.com"
license          "Apache 2.0"
description      "Deploys and configures Node.js applications"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.1"

%w{ debian ubuntu }.each {|os| supports os}

%w{ nodejs nginx openssl supervisor }.each {|c| depends c}

depends          "application", "= 2.0.4"
suggests         "strongloop"