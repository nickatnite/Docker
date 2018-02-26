# xxxxxxxxxx Web Sever Docker Build

Build container by running build.sh and follow the prompts!

To connect to the container on MAC when running locally do the following:

```docker run -p 443:443 -d <image-id>```

```docker exec -it <container-id> /bin/bash```
```Invictus:.ssh nascione$ docker exec -it 9b3ee98b6a1d  /bin/bash
root@9b3ee98b6a1d:/# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.4 101032  9564 ?        Ss   08:37   0:01 /usr/sbin/apache2 -D FOREGROUND
www-data     9  0.0  3.7 399864 77576 ?        Sl   08:37   0:01 (wsgi:api)        -D FOREGROUND
www-data    10  0.0  3.7 465408 77472 ?        Sl   08:37   0:01 (wsgi:api)        -D FOREGROUND
www-data    11  0.0  3.7 399864 77236 ?        Sl   08:37   0:02 (wsgi:api)        -D FOREGROUND
www-data    12  0.0  3.7 399864 77576 ?        Sl   08:37   0:01 (wsgi:api)        -D FOREGROUND
www-data    13  0.0  0.4 308156  9284 ?        Sl   08:37   0:00 (wsgi:api)        -D FOREGROUND
www-data    14  0.0  0.4 308156  9316 ?        Sl   08:37   0:00 (wsgi:app)        -D FOREGROUND
www-data    15  0.0  0.4 308148  9316 ?        Sl   08:37   0:00 (wsgi:app)        -D FOREGROUND
www-data    16  0.0  0.4 308148  9316 ?        Sl   08:37   0:00 (wsgi:app)        -D FOREGROUND
www-data    17  0.0  0.4 308148  9316 ?        Sl   08:37   0:00 (wsgi:app)        -D FOREGROUND
www-data    18  0.0  0.4 308148  9316 ?        Sl   08:37   0:00 (wsgi:app)        -D FOREGROUND
www-data    19  0.0  0.4 308148  9312 ?        Sl   08:37   0:00 (wsgi:quote)      -D FOREGROUND
www-data    20  0.0  0.4 308148  9272 ?        Sl   08:37   0:00 (wsgi:quote)      -D FOREGROUND
www-data    21  0.0  0.4 308156  9316 ?        Sl   08:37   0:00 (wsgi:quote)      -D FOREGROUND
www-data    22  0.0  0.4 308148  9316 ?        Sl   08:37   0:00 (wsgi:quote)      -D FOREGROUND
www-data    23  0.0  0.4 308148  9316 ?        Sl   08:37   0:00 (wsgi:quote)      -D FOREGROUND
www-data    24  0.0  0.6 457944 12356 ?        Sl   08:37   0:13 /usr/sbin/apache2 -D FOREGROUND
www-data    25  0.0  0.5 654552 12068 ?        Sl   08:37   0:14 /usr/sbin/apache2 -D FOREGROUND
root       358  2.5  0.1  18248  3172 pts/0    Ss   17:39   0:00 /bin/bash
root       372  0.0  0.1  34424  2820 pts/0    R+   17:39   0:00 ps aux
root@9b3ee98b6a1d:/# tail -f /var/log/apache2/error.log
[Thu Aug 17 14:39:16.071910 2017] [wsgi:error] [pid 9:tid 140690041194240] [remote 172.17.0.1:60914]     import applications
```




Nick Ascione
08/17/2017
version 0.0.1

