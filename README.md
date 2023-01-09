# Openstack CLI

I was tired of not find any images that contains all CLI from openstack
So I bundle them into single Image

## How to build

`docker build -f Dockerfile`

## How to update 

`poetry lock && docker build -f Dockerfile`
