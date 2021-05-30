# geoiplookup

## Introduction

This repository contains the following components:

- **hosts.txt**: file provided to the author by e-mail with DNS names to use with geoiplookup binary
- **geoiplookup.sh**: bash script which runs in parallel the geoiplookup binary with a list of DNS names, and this list can be passed either as parameters or as text file
- **Dockerfile**: dockerfile to build a Docker image which runs `geoiplookup.sh` bash script with DNS names from `hosts.txt` 
- **docker-compose.yaml**: Docker Compose file to manage Docker container which has been built with previous Dockerfile
- **geoiplookup**: folder which contains geoiplookup Chef cookbook

## geoiplookup.sh usage

This script can be run either using DNS names as parameters or as text file. 

Example using parameters:
```
$ ./geoiplookup.sh mail.sodoit.com www.ingrammicrocloud.com
www.ingrammicrocloud.com: GeoIP Country Edition: ES, Spain
mail.sodoit.com: GeoIP Country Edition: VG, Virgin Islands, British
```

Example using text file:
```
$ ./geoiplookup.sh ./hosts.txt 
thumbs2.ebaystatic.com: GeoIP Country Edition: NL, Netherlands
www.mediafire.com: GeoIP Country Edition: US, United States
s-static.ak.fbcdn.net: GeoIP Country Edition: can't resolve hostname ( s-static.ak.fbcdn.net ) GeoIP Country V6 Edition: can't resolve hostname ( s-static.ak.fbcdn.net )
sip.hotmail.com: GeoIP Country Edition: can't resolve hostname ( sip.hotmail.com ) GeoIP Country V6 Edition: can't resolve hostname ( sip.hotmail.com )
lachicabionica.com: GeoIP Country Edition: can't resolve hostname ( lachicabionica.com ) GeoIP Country V6 Edition: can't resolve hostname ( lachicabionica.com )
mountaineerpublishing.com: GeoIP Country Edition: US, United States
www.freemarket.com: GeoIP Country Edition: ES, Spain
google.com: GeoIP Country Edition: US, United States
www.inrammicrocloud.com: GeoIP Country Edition: can't resolve hostname ( www.inrammicrocloud.com ) GeoIP Country V6 Edition: can't resolve hostname ( www.inrammicrocloud.com )
developers.facebook.com: GeoIP Country Edition: US, United States
www.eucarvet.eu: GeoIP Country Edition: can't resolve hostname ( www.eucarvet.eu ) GeoIP Country V6 Edition: can't resolve hostname ( www.eucarvet.eu )
mail.mobilni-telefony.biz: GeoIP Country Edition: NL, Netherlands
profile.ak.fbcdn.net: GeoIP Country Edition: can't resolve hostname ( profile.ak.fbcdn.net ) GeoIP Country V6 Edition: can't resolve hostname ( profile.ak.fbcdn.net )
ads.smowtion.com: GeoIP Country Edition: can't resolve hostname ( ads.smowtion.com ) GeoIP Country V6 Edition: can't resolve hostname ( ads.smowtion.com )
www.zunescene.mobi: GeoIP Country Edition: US, United States
microsoft-powerpoint-2010.softonic.it: GeoIP Country Edition: US, United States
armandi.ru: GeoIP Country Edition: RU, Russian Federation
m.addthisedge.com: GeoIP Country Edition: can't resolve hostname ( m.addthisedge.com ) GeoIP Country V6 Edition: can't resolve hostname ( m.addthisedge.com )
solofarandulaperu.blogspot.com: GeoIP Country Edition: US, United States
ssl.google-analytics.com: GeoIP Country Edition: can't resolve hostname ( ssl.google-analytics.com ) GeoIP Country V6 Edition: can't resolve hostname ( ssl.google-analytics.com )
243.35.149.83.in-addr.arpa: GeoIP Country Edition: can't resolve hostname ( 243.35.149.83.in-addr.arpa ) GeoIP Country V6 Edition: can't resolve hostname ( 243.35.149.83.in-addr.arpa )
105.138.138.201.in-addr.arpa: GeoIP Country Edition: can't resolve hostname ( 105.138.138.201.in-addr.arpa ) GeoIP Country V6 Edition: can't resolve hostname ( 105.138.138.201.in-addr.arpa )
www.reuters.com: GeoIP Country Edition: US, United States
mail.sodoit.com: GeoIP Country Edition: VG, Virgin Islands, British
196.127.197.94.in-addr.arpa: GeoIP Country Edition: can't resolve hostname ( 196.127.197.94.in-addr.arpa ) GeoIP Country V6 Edition: can't resolve hostname ( 196.127.197.94.in-addr.arpa )
resquare.ca: GeoIP Country Edition: can't resolve hostname ( resquare.ca ) GeoIP Country V6 Edition: can't resolve hostname ( resquare.ca )
www.download.windowsupdate.com: GeoIP Country Edition: EU, Europe
www.ingrammicrocloud.com: GeoIP Country Edition: ES, Spain
cache.defamer.com: GeoIP Country Edition: can't resolve hostname ( cache.defamer.com ) GeoIP Country V6 Edition: can't resolve hostname ( cache.defamer.com )
```

## Dockerfile usage

Run in folder where Dockerfile is located:

```
$ docker build . -t antoniodiazroman/ingram:v0.1
Sending build context to Docker daemon  113.7kB
Step 1/9 : FROM debian:buster-slim
 ---> 80b9e7aadac5
Step 2/9 : RUN apt-get update && apt-get install -y parallel geoip-bin
 ---> Using cache
 ---> c0f6ede9819c
Step 3/9 : RUN mkdir /opt/geoip
 ---> Using cache
 ---> cf2a2dc180bb
Step 4/9 : WORKDIR /opt/geoip
 ---> Using cache
 ---> 5298fe7165df
Step 5/9 : COPY geoiplookup.sh .
 ---> e8cde96299f5
Step 6/9 : RUN chmod +x ./geoiplookup.sh
 ---> Running in 1bd28846ffe3
Removing intermediate container 1bd28846ffe3
 ---> 65450aea9c52
Step 7/9 : RUN touch /opt/hosts.txt
 ---> Running in 61cdd283e8db
Removing intermediate container 61cdd283e8db
 ---> 156fb8fa5081
Step 8/9 : ENTRYPOINT [ "/opt/geoip/geoiplookup.sh" ]
 ---> Running in 975f9a04b0f8
Removing intermediate container 975f9a04b0f8
 ---> 263631fd07c5
Step 9/9 : CMD [ "/opt/hosts.txt" ]
 ---> Running in 19b65077877e
Removing intermediate container 19b65077877e
 ---> 32eb3cfba9b5
Successfully built 32eb3cfba9b5
Successfully tagged antoniodiazroman/ingram:v0.1
```

```
$ docker image ls
REPOSITORY                    TAG           IMAGE ID       CREATED          SIZE
antoniodiazroman/ingram       v0.1          32eb3cfba9b5   19 seconds ago   231MB
```

## docker-compose.yaml usage

This Docker Compose file allows to run the Docker image built in the previous step:

```
$ docker-compose up -d && docker-compose logs -ft
Creating geoiplookup ... done
Attaching to geoiplookup
geoiplookup    | 2021-05-30T14:10:09.383382893Z mountaineerpublishing.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:09.386627034Z www.mediafire.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:09.476780135Z www.freemarket.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:09.545889607Z s-static.ak.fbcdn.net: GeoIP Country Edition: can't resolve hostname ( s-static.ak.fbcdn.net ) GeoIP Country V6 Edition: can't resolve hostname ( s-static.ak.fbcdn.net )
geoiplookup    | 2021-05-30T14:10:09.549190230Z thumbs2.ebaystatic.com: GeoIP Country Edition: NL, Netherlands
geoiplookup    | 2021-05-30T14:10:09.604719861Z lachicabionica.com: GeoIP Country Edition: can't resolve hostname ( lachicabionica.com ) GeoIP Country V6 Edition: can't resolve hostname ( lachicabionica.com )
geoiplookup    | 2021-05-30T14:10:09.611456106Z google.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:09.665767591Z developers.facebook.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:09.803261260Z www.inrammicrocloud.com: GeoIP Country Edition: can't resolve hostname ( www.inrammicrocloud.com ) GeoIP Country V6 Edition: can't resolve hostname ( www.inrammicrocloud.com )
geoiplookup    | 2021-05-30T14:10:09.866539034Z mail.mobilni-telefony.biz: GeoIP Country Edition: NL, Netherlands
geoiplookup    | 2021-05-30T14:10:09.895310692Z www.eucarvet.eu: GeoIP Country Edition: can't resolve hostname ( www.eucarvet.eu ) GeoIP Country V6 Edition: can't resolve hostname ( www.eucarvet.eu )
geoiplookup    | 2021-05-30T14:10:09.926385649Z microsoft-powerpoint-2010.softonic.it: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:09.988457333Z www.zunescene.mobi: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:10.050897001Z ads.smowtion.com: GeoIP Country Edition: can't resolve hostname ( ads.smowtion.com ) GeoIP Country V6 Edition: can't resolve hostname ( ads.smowtion.com )
geoiplookup    | 2021-05-30T14:10:10.107743318Z 196.127.197.94.in-addr.arpa: GeoIP Country Edition: can't resolve hostname ( 196.127.197.94.in-addr.arpa ) GeoIP Country V6 Edition: can't resolve hostname ( 196.127.197.94.in-addr.arpa )
geoiplookup    | 2021-05-30T14:10:10.182129509Z armandi.ru: GeoIP Country Edition: RU, Russian Federation
geoiplookup    | 2021-05-30T14:10:10.246016986Z solofarandulaperu.blogspot.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:10.305378696Z m.addthisedge.com: GeoIP Country Edition: can't resolve hostname ( m.addthisedge.com ) GeoIP Country V6 Edition: can't resolve hostname ( m.addthisedge.com )
geoiplookup    | 2021-05-30T14:10:10.357083483Z ssl.google-analytics.com: GeoIP Country Edition: can't resolve hostname ( ssl.google-analytics.com ) GeoIP Country V6 Edition: can't resolve hostname ( ssl.google-analytics.com )
geoiplookup    | 2021-05-30T14:10:10.590244464Z 243.35.149.83.in-addr.arpa: GeoIP Country Edition: can't resolve hostname ( 243.35.149.83.in-addr.arpa ) GeoIP Country V6 Edition: can't resolve hostname ( 243.35.149.83.in-addr.arpa )
geoiplookup    | 2021-05-30T14:10:10.648785764Z 105.138.138.201.in-addr.arpa: GeoIP Country Edition: can't resolve hostname ( 105.138.138.201.in-addr.arpa ) GeoIP Country V6 Edition: can't resolve hostname ( 105.138.138.201.in-addr.arpa )
geoiplookup    | 2021-05-30T14:10:10.721111680Z www.reuters.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:10.791235755Z mail.sodoit.com: GeoIP Country Edition: VG, Virgin Islands, British
geoiplookup    | 2021-05-30T14:10:10.870783767Z www.download.windowsupdate.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:10.938000180Z resquare.ca: GeoIP Country Edition: can't resolve hostname ( resquare.ca ) GeoIP Country V6 Edition: can't resolve hostname ( resquare.ca )
geoiplookup    | 2021-05-30T14:10:11.000925098Z www.ingrammicrocloud.com: GeoIP Country Edition: US, United States
geoiplookup    | 2021-05-30T14:10:15.121430368Z profile.ak.fbcdn.net: GeoIP Country Edition: can't resolve hostname ( profile.ak.fbcdn.net ) GeoIP Country V6 Edition: can't resolve hostname ( profile.ak.fbcdn.net )
geoiplookup    | 2021-05-30T14:10:15.726466823Z cache.defamer.com: GeoIP Country Edition: can't resolve hostname ( cache.defamer.com ) GeoIP Country V6 Edition: can't resolve hostname ( cache.defamer.com )
geoiplookup    | 2021-05-30T14:10:17.602193111Z sip.hotmail.com: GeoIP Country Edition: can't resolve hostname ( sip.hotmail.com ) GeoIP Country V6 Edition: can't resolve hostname ( sip.hotmail.com )
geoiplookup exited with code 0
```

## geoiplookup Cookbook

This Chef Cookbook has been tested running the following commands:

In why-run mode:
```
$ chef-client --local-mode --why-run geoiplookup/recipes/default.rb 
[2021-05-30T16:11:35+02:00] WARN: No config file found or specified on command line. Using command line options instead.
[2021-05-30T16:11:35+02:00] WARN: No cookbooks directory found at or above current directory.  Assuming /home/tony/Nextcloud/Documentos/test_ingram/entrega.
Starting Chef Infra Client, version 16.10.8
Patents: https://www.chef.io/patents
[2021-05-30T16:11:39+02:00] ERROR: shard_seed: Failed to get dmi property serial_number: is dmidecode installed?
resolving cookbooks for run list: []
Synchronizing Cookbooks:
Installing Cookbook Gems:
Compiling Cookbooks...
[2021-05-30T16:11:43+02:00] WARN: Node xps has an empty run list.
Converging 3 resources
Recipe: @recipe_files::/home/tony/Nextcloud/Documentos/test_ingram/entrega/geoiplookup/recipes/default.rb
  * directory[/opt/geoip] action create (up to date)
  * file[/opt/geoip/geoiplookup.sh] action create (up to date)
  * execute[Get GeoIP info] action run
    - Would execute /opt/geoip/geoiplookup.sh www.reuters.com mail.sodoit.com www.download.windowsupdate.com resquare.ca www.ingrammicrocloud.com > /opt/geoip/result.txt
[2021-05-30T16:11:43+02:00] WARN: In why-run mode, so NOT performing node save.

Running handlers:
Running handlers complete
Chef Infra Client finished, 1/3 resources would have been updated
```

In real mode:
```
$ chef-client --local-mode geoiplookup/recipes/default.rb 
[2021-05-30T16:13:35+02:00] WARN: No config file found or specified on command line. Using command line options instead.
[2021-05-30T16:13:35+02:00] WARN: No cookbooks directory found at or above current directory.  Assuming /home/tony/Nextcloud/Documentos/test_ingram/entrega.
Starting Chef Infra Client, version 16.10.8
Patents: https://www.chef.io/patents
[2021-05-30T16:13:37+02:00] ERROR: shard_seed: Failed to get dmi property serial_number: is dmidecode installed?
resolving cookbooks for run list: []
Synchronizing Cookbooks:
Installing Cookbook Gems:
Compiling Cookbooks...
[2021-05-30T16:13:38+02:00] WARN: Node xps has an empty run list.
Converging 3 resources
Recipe: @recipe_files::/home/tony/Nextcloud/Documentos/test_ingram/entrega/geoiplookup/recipes/default.rb
  * directory[/opt/geoip] action create
    - create new directory /opt/geoip
    - change mode from '' to '0755'
    - change owner from '' to 'tony'
    - change group from '' to 'tony'
  * file[/opt/geoip/geoiplookup.sh] action create
    - create new file /opt/geoip/geoiplookup.sh
    - update content in file /opt/geoip/geoiplookup.sh from none to 02bb0f
    --- /opt/geoip/geoiplookup.sh	2021-05-30 16:13:38.592875932 +0200
    +++ /opt/geoip/.chef-geoiplookup20210530-5774-12mahcb.sh	2021-05-30 16:13:38.592875932 +0200
    @@ -1 +1,15 @@
    +#!/bin/bash
    +
    +if [[ $# -eq 0 ]];
    +then
    +    echo "Usages:"
    +    echo "# geoiplookup.sh host1 host2 ... hostN"
    +    echo "# geoiplookup.sh hostsfile.txt"
    +    exit 1
    +elif [[ $# -eq 1 && -f $1 ]];
    +then
    +    parallel --gnu -j $(nproc) "echo \"{}: \"\$(geoiplookup {})" ::: $(cat $1)
    +else
    +    parallel --gnu -j $(nproc) "echo \"{}: \"\$(geoiplookup {})" ::: $@
    +fi
    - change mode from '' to '0744'
    - change owner from '' to 'tony'
    - change group from '' to 'tony'
  * execute[Get GeoIP info] action run
    - execute /opt/geoip/geoiplookup.sh www.reuters.com mail.sodoit.com www.download.windowsupdate.com resquare.ca www.ingrammicrocloud.com > /opt/geoip/result.txt

Running handlers:
Running handlers complete
Chef Infra Client finished, 3/3 resources updated in 03 seconds
```
```
$ cat /opt/geoip/result.txt 
mail.sodoit.com: GeoIP Country Edition: VG, Virgin Islands, British
www.download.windowsupdate.com: GeoIP Country Edition: US, United States
resquare.ca: GeoIP Country Edition: can't resolve hostname ( resquare.ca ) GeoIP Country V6 Edition: can't resolve hostname ( resquare.ca )
www.reuters.com: GeoIP Country Edition: US, United States
www.ingrammicrocloud.com: GeoIP Country Edition: US, United States
```
