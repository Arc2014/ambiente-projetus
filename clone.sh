#!/bin/bash
PATH_TO="/home/aureliorezendecosta/desenv/projetus/$1"
USER="Arc2014"
#Clone project
git clone https://$USER@bitbucket.org/projetus/$1.git $PATH_TO