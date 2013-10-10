maintainer       "Conrad Kramer"
maintainer_email "conrad@kramerapps.com"
license          "Apache 2.0"
description      "Deploys and configures Node.js applications"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.2"

depends          "nodejs"
depends          "application"

suggests         "strongloop"

supports 'ubuntu', ">= 12.04"
