# Munin master with munstrap

It based on 
- [docker-munin yacchin fork](https://github.com/yacchin1205/docker-munin)
- [Munstrap](https://github.com/jonnymccullagh/munstrap)

# How to use
## in Japanese 
[DockerでさくっとMunin masterをつくる](http://qiita.com/yacchin1205/items/4a23193c47fec4dbcb6b) (japanese: written by yacchin)

## in Engrish X(

* `docker build -t docker-munstrap .`
* `docker run -d -p 80:80 docker-munstrap`
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

# completely example
`docker run -d -p 80:80 -e NOEDS="foo.local:127.0.0.1 bar.remote:1.2.3.4" -v /etc/localtime:/etc/localtime:ro -v /var/lib/munin:/var/lib/munin docker-munstrap`
