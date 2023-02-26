# chomosuke.com
2023

[Source Code](https://github.com/chomosuke/chomosuke.com)

## Summary
Infrastructure for hosting my various websites on AWS ECS.

## Description
- After Heroku [discontinued their free hosting offer](https://blog.heroku.com/next-chapter), a number of my side project websites hosted on Heroku went down.
- To bring the sites back up, and to learn [AWS](../skills/aws.md), I decided to deploy all of my websites on AWS as [Docker](../skills/docker.md) containers.
- After learning the basics of AWS, I purchased a single EC2 t4g.nano reserved instance and created an ECS cluster with it that would host all my websites.
- To make my websites secure, I created a docker container running an [NGINX](../skills/nginx.md) server as an SSL reverse proxy. It uses let's encrypt's certbot to obtain wild card certificates for the domain name: "chomosuke.com" which I purchased for this purpose.
- After some trial and error, I was able to bring all my websites back up under various subdomains of "chomosuke.com". I also set up continuous deployment with [CircleCI](../skills/circleci.md) for all the websites.
- I also wrote detailed instruction in the project's [README](https://github.com/chomosuke/chomosuke.com/blob/master/README.md) so that I can easily deploy any future websites that I make.
