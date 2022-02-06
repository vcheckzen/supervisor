# Supervisor

Manage multiple programs by groups, working on all unix-like systems. Just a demo, do not use in production.

## Usage

```bash
Supervisor: manage multiple programs by groups.
Usage: ./main.sh [COMMAND] [OPTION] [ARGS]...

COMMAND
    start       start programs by groups or names
    stop        stop programs by groups or names
    status      print process running status by groups or names

OPTION
    -g          group, followed by a group name

ARGS            multiple groups or program names
```

## Examples

### Start all programs in the config file

```bash
➜  supervisor git:(master) ./main.sh start
============================================================================================= 
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
============================================================================================= 
 nginx           WEB             RUNNING 10939   0.0     0.0        Fri Mar 12 20:57:24 2021
 httpd           WEB             RUNNING 10956   0.0     0.0        Fri Mar 12 20:57:24 2021
 mysql           DB              RUNNING 10982   0.0     0.0        Fri Mar 12 20:57:24 2021
 postgresql      DB              RUNNING 11002   0.0     0.0        Fri Mar 12 20:57:24 2021
 oracle          DB              RUNNING 11022   0.0     0.0        Fri Mar 12 20:57:24 2021
 datanode        HADOOP          RUNNING 11051   0.0     0.0        Fri Mar 12 20:57:24 2021
 namenode        HADOOP          RUNNING 11074   0.0     0.0        Fri Mar 12 20:57:24 2021
 journalnode     HADOOP          RUNNING 11097   0.0     0.0        Fri Mar 12 20:57:24 2021
 resourcemanager YARN            RUNNING 11129   0.0     0.0        Fri Mar 12 20:57:24 2021
 nodemanager     YARN            RUNNING 11155   0.0     0.0        Fri Mar 12 20:57:24 2021
```

### Start programs by groups

```bash
➜  supervisor git:(master) ./main.sh start -g WEB DB
=============================================================================================
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
=============================================================================================
 nginx           WEB             RUNNING 11869   0.0     0.0        Fri Mar 12 21:04:39 2021
 httpd           WEB             RUNNING 11886   0.0     0.0        Fri Mar 12 21:04:39 2021
 mysql           DB              RUNNING 11912   0.0     0.0        Fri Mar 12 21:04:39 2021
 postgresql      DB              RUNNING 11932   0.0     0.0        Fri Mar 12 21:04:39 2021
 oracle          DB              RUNNING 11952   0.0     0.0        Fri Mar 12 21:04:39 2021
```

### Start programs by names

```bash
➜  supervisor git:(master) ./main.sh start nginx mysql
=============================================================================================
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
=============================================================================================
 nginx           WEB             RUNNING 12660   0.0     0.0        Fri Mar 12 21:07:55 2021
 mysql           DB              RUNNING 12680   0.0     0.0        Fri Mar 12 21:07:55 2021
```

### Stop all programs in the config file

```bash
➜  supervisor git:(master) ./main.sh stop
=============================================================================================
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
=============================================================================================
 nginx           WEB             STOPPED NULL    NULL    NULL                           NULL
 httpd           WEB             STOPPED NULL    NULL    NULL                           NULL
 mysql           DB              STOPPED NULL    NULL    NULL                           NULL
 postgresql      DB              STOPPED NULL    NULL    NULL                           NULL
 oracle          DB              STOPPED NULL    NULL    NULL                           NULL
 datanode        HADOOP          STOPPED NULL    NULL    NULL                           NULL
 namenode        HADOOP          STOPPED NULL    NULL    NULL                           NULL
 journalnode     HADOOP          STOPPED NULL    NULL    NULL                           NULL
 resourcemanager YARN            STOPPED NULL    NULL    NULL                           NULL
 nodemanager     YARN            STOPPED NULL    NULL    NULL                           NULL
```

### Stop programs by groups

```bash
➜  supervisor git:(master) ./main.sh stop -g WEB DB
=============================================================================================
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
=============================================================================================
 nginx           WEB             STOPPED NULL    NULL    NULL                           NULL
 httpd           WEB             STOPPED NULL    NULL    NULL                           NULL
 mysql           DB              STOPPED NULL    NULL    NULL                           NULL
 postgresql      DB              STOPPED NULL    NULL    NULL                           NULL
 oracle          DB              STOPPED NULL    NULL    NULL                           NULL
```

### Stop programs by names

```bash
➜  supervisor git:(master) ./main.sh stop nginx mysql
=============================================================================================
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
=============================================================================================
 nginx           WEB             STOPPED NULL    NULL    NULL                           NULL
 mysql           DB              STOPPED NULL    NULL    NULL                           NULL
```

### Print all programs status

```bash
➜  supervisor git:(master) ./main.sh status
=============================================================================================
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
=============================================================================================
 nginx           WEB             STOPPED NULL    NULL    NULL                           NULL
 httpd           WEB             STOPPED NULL    NULL    NULL                           NULL
 mysql           DB              STOPPED NULL    NULL    NULL                           NULL
 postgresql      DB              STOPPED NULL    NULL    NULL                           NULL
 oracle          DB              STOPPED NULL    NULL    NULL                           NULL
 datanode        HADOOP          STOPPED NULL    NULL    NULL                           NULL
 namenode        HADOOP          STOPPED NULL    NULL    NULL                           NULL
 journalnode     HADOOP          STOPPED NULL    NULL    NULL                           NULL
 resourcemanager YARN            STOPPED NULL    NULL    NULL                           NULL
 nodemanager     YARN            STOPPED NULL    NULL    NULL                           NULL
```

### Print programs status by groups

```bash
➜  supervisor git:(master) ./main.sh status -g WEB DB
=============================================================================================
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
=============================================================================================
 nginx           WEB             STOPPED NULL    NULL    NULL                           NULL
 httpd           WEB             STOPPED NULL    NULL    NULL                           NULL
 mysql           DB              STOPPED NULL    NULL    NULL                           NULL
 postgresql      DB              STOPPED NULL    NULL    NULL                           NULL
 oracle          DB              STOPPED NULL    NULL    NULL                           NULL
```

### Print programs status by names

```bash
➜  supervisor git:(master) ./main.sh status nginx mysql
=============================================================================================
 PROCESS_NAME    GROUP           STATUS  PID     CPU     MEM                      START_TIME
=============================================================================================
 nginx           WEB             STOPPED NULL    NULL    NULL                           NULL
 mysql           DB              STOPPED NULL    NULL    NULL                           NULL
```
