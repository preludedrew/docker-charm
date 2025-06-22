### Instructions below are mainly for Debian/Ubuntu based OS's. This can be easily adapted to work with any Linux OS though. The container base image is `ubuntu:20.04`.

#### Notes:

* I've taken steps/info from multiple sources and made this a little simpler to deploy. I'll list below some of the original content I used. Some notable changes are like modifying the `start.sh`. I've moved some of the setup into the docker image.

```
https://charm.li/
https://github.com/rOzzy1987/charm.li
https://www.reddit.com/r/mechanic/comments/1iq0qjh/operation_charmli_is_down_but_not_lost/
https://archive.org/details/charm.li_data_202306
```

I've only briefly looked, but have yet to figure out how to mount a squashfs image inside of a container without using `--privileged`. If someone has a better solution, please let me know. I'll do some digging at some point in time.


## Setup procedure

1) Download database files. You need the squashfs image, and the large ~650GB file (named data.mdb, but needs to stay in the `lmdb-images/` sub-dir). Where you get the files doesn't necessarily matter. I was able to download these from archive.org slowly, but successfully.
```
https://archive.org/download/charm.li_data_202306/operation-charm/
```
  These need to be in the same directory and the structure should look like this:
  ```
  data
  ├── lmdb-images
  │   └── data.mdb
  └── lmdb-pages.sqsh
  ```
  
2) Install docker.io package (Debian/Ubuntu derived OS)

```sudo apt install docker.io```
   
3) Create/Run the docker container. Need to mount the directory where the database and squashfs are located. Replace `<database_dir>` with the full path to this directory. You can use a nfs share, samba share, or even an external disk. Just need to mount it and record where it's mounted.
```
sudo docker run -d --privileged -v <database_dir>:/data --name Charm -p 8080:8080 preludedrew/docker-charm:latest
```

4) You can verify it's working by running a curl.
```
curl localhost:8080
```

5) Navigate to the website. Localhost will work, but so should direct IP. Use Chrome, firefox, whatever.
```
http://localhost:8080
```

## Troubleshooting
---

#### If you run into any issues, you can grab the logs from the container. This won't give you a ton, but might indicate something.
```
sudo docker logs -f Charm
```
#### In case the logs indicate you need to look at a log file. You can shell into the container and then cat the log files with:
```
sudo docker exec -it Charm bash
```
