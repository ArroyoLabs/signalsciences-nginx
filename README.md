# signalsciences-nginx

Docker support for Signal Sciences WAF integration with NGINX.  Find us on dockerhub at 
https://hub.docker.com/r/arroyolabs/signalsciences-nginx

Created by John Arroyo for [Arroyo Labs](https://www.arroyolabs.com/) for client projects.

[Signal Sciences](https://www.signalsciences.com/), [Nginx](https://nginx.org/), [Arroyo Labs](https://www.arroyolabs.com/)

## Usage

```
docker pull arroyolabs/signalsciences-nginx
```


Volume map your or copy into to your child image your Signal Sciences agent config

/etc/sigsci/agent.conf

Do the same for you your nginx configs, for instance /etc/nginx/conf.d/site.conf

Enjoy!
