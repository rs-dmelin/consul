#!/bin/bash
docker rmi -f $(docker images -a -q)
$rvm_recommended_ruby
sudo yum update
sudo yum install -y postgresql96-server postgresql96-devel postgresql96-libs postgresql96-contrib ImageMagick-devel
sudo service postgresql96 initdb
sudo sed -i 's/peer/trust/g' /var/lib/pgsql96/data/pg_hba.conf
sudo service postgresql96 start
bundle install
cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
bin/rake db:create
bin/rake db:migrate
bin/rake db:dev_seed
