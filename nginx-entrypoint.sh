#!/bin/bash
erb -T - /nginx.conf.erb > /etc/nginx/nginx.conf
exec ${@}
