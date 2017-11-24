#!/bin/bash
echo  "$(/sbin/ip route|awk '/default/ { print $3 }') databases" >> /etc/hosts
rake db:create db:migrate
bundle exec rails s -p $1 -b '0.0.0.0'
