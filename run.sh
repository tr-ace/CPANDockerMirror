#!/bin/bash
dockerk stop cpan-mirror
docker rm -f cpan-mirror
docker build --no-cache -t cpan-mirror .
docker run -d --name cpan-mirror -p 80:80 cpan-mirror