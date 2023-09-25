## derpibooru-db-undump
#### Deploys a docker container with postgres and loads the database dump from derpibooru into it
An installed [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [docker](https://docs.docker.com/engine/install/) is required for startup.

It is desirable to execute [post-installation steps](https://docs.docker.com/engine/install/linux-postinstall/).

The instructions and scripts are written with the assumption that you have completed them.

You will also need [bash](https://github.com/exercism/bash/blob/main/docs/INSTALLATION.md), as the scripts use some tricks to find files automatically.<br><br>

Attention
---
Keep in mind that as of 2023-09, you need more than 35 gigabytes of free space to deploy the dump of the derpibooru database. In fact, you still need 4.5 gigabytes (x2 because the file is copied inside the container) for the dump itself and some memory for the docker itself.
So for the minimum you can call it about 47-50 gigabytes of free space


Let's get started
---
Step one:
```bash
git clone https://github.com/MLPch/derpibooru-db-undump.git ./derpibooru-db-undump && cd derpibooru-db-undump
```
<br>

Step two:
```bash
chmod +x ./run.sh ./stop.sh ./start.sh ./rm-all.sh
```
<br>

If you don't have the derpibooru database dump yet, the script will prompt you to go to [the page](https://www.derpibooru.org/pages/data_dumps) where the download link is located.

This page also tells you which version of PostgreSQL you need. If necessary, change it to the correct one in [Dockerfile](Dockerfile).
<br>

Step three:
```bash
./run.sh
```
<br>

#### Keep in mind that undumping a database can take quite a long time ~1-3 hours depending on your disk and CPU performance.  
It is recommended that you use [tmux](https://github.com/tmux/tmux/wiki/Getting-Started) to run it
```
tmux new -s derpibooru-db-undump -d
tmux send-keys -t derpibooru-db-undump "./run.sh" Enter
```
They may need to be run with root privileges `sudo -s`.

To connect to an already running terminal, use the command:
```
tmux attach -t derpibooru-db-undump
```
Also with root privileges if you've do it before.
<br>
<br>

Attention
---
The database is completely open to connections from the host machine, as well as to connections from the outside if you do not have a firewall configured.

Make changes to the [external-access.sh](dump/external-access.sh) file if you don't want to do this. 
Related Materials:
- [listen addresses](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-LISTEN-ADDRESSES)
- [postgresql.conf](https://www.postgresql.org/docs/current/config-setting.html#CONFIG-SETTING-CONFIGURATION-FILE)
- [pg_hba.conf](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html#AUTH-PG-HBA-CONF)
<br>
<br>

Use this data to connect to the database on the host machine:
```
USER      = postgres
PASSWORD  = postgres
IP        = localhost
PORT      = 5532
```

If you are deploying the database on a remote machine, you can use its IP to connect to the database

You should also check if port 5532 is available externally.

To stop the container, use the command:
```
./stop.sh
```
Please do not stop the container until the undumping process is complete to avoid errors

To start an already created container, use the command:
```
./start.sh
```
<br>

Remove all
---
To stop and delete all containers and images associated with this project, run these commands in sequence:
```
./rm-all.sh
cd ..
rm -r ./derpibooru-db-undump
```
Also, if you have docker containers running, check out [this](https://docs.docker.com/engine/reference/commandline/system_prune/) and [this tutorials](https://docs.docker.com/config/pruning/) for a more thorough cleanup if needed.


If you are not using docker containers, you can simply run these two commands, which will clean up as much as possible.
```
docker system prune -f
docker system prune -a -f --volumes
```
