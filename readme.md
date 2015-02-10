# Munin master with munstrap
[![Docker Repository on Quay.io](https://quay.io/repository/kyohsuke/docker-munstrap/status "Docker Repository on Quay.io")](https://quay.io/repository/kyohsuke/docker-munstrap)

It based on 
- [docker-munin yacchin fork](https://github.com/yacchin1205/docker-munin)
- [Munstrap](https://github.com/jonnymccullagh/munstrap)

# tl;dr
```
docker pull quay.io/kyohsuke/docker-munstrap:latest
docker run -d -p 80:80 \
-e CAPTURE_HOST=true \
-e NOEDS="foo.local:127.0.0.1 bar.remote:1.2.3.4" \
-v /etc/localtime:/etc/localtime:ro \
-v /var/lib/munin:/var/lib/munin \
kyohsuke/docker-munstrap
```

# How to use
[DockerでさくっとMunin masterをつくる](http://qiita.com/yacchin1205/items/4a23193c47fec4dbcb6b) (japanese: written by yacchin)

* `docker pull quay.io/kyohsuke/docker-munstrap:latest`
* `docker run -d -p 80:80 kyohsuke/docker-munstrap`
* access http://127.0.0.1/ on your browser.

# Environment Variables

* `NODES`: Space separated list of `<name>:<host>` munin node pairs. (i.e. `foo.local:127.0.0.1 bar.remote:1.2.3.4`)  
  
example)  
`docker run -d -p 80:80 -e NOEDS="foo.local:127.0.0.1 bar.remote:1.2.3.4" docker-munstrap` 

# sync timezone host<->guest
mount /etc/localtime with Readonly  
`-v /etc/localtime:/etc/localtime:ro`

# store metrics data
mount host directory with Read/Write  
`-v /path/your/store/dir/munin:/var/lib/munin`

# capture Docker host metrics
`-e CAPTURE_HOST=true`
