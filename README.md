# docker-valutod

The official docker container for running `valutod` for any system that supports Docker.

Can be used for testing the RPC client, application development or even as a way to get 
started quickly with `valutod` without compiling anything.

## Usage

```bash
mkdir valuto-data
docker run \
  --volume $(pwd)/valuto-data:/valuto-data \
  --publish 127.0.0.1:40332:40332 \
  --publish 40333:40333 \
  --publish 41333:41333 \
  --name valutod \
   valuto/valutod
```

*Important*:
Never publish port 40332 to all interfaces. This is a security-sensitive RPC API, so only expose 
it beyond 127.0.0.1 if you know what you're doing.

The first time you start the container, it will exit with the following error message:

```
Error: To use valutod, you must set a rpcpassword in the configuration file:
/valuto-data/valutod.conf
It is recommended you use the following random password:
rpcuser=valutorpc
rpcpassword=3qyKyurz9WvAag3b7cNo2A1pU8fBUsip3TRXWa45WBsV
(you do not need to remember this password)
The username and password MUST NOT be the same.
If the file does not exist, create it with owner-readable-only file permissions.
It is also recommended to set alertnotify so you are notified of problems;
for example: alertnotify=echo %s | mail -s "Valuto Alert" admin@foo.com
```

You should create the file valuto.conf in the `valuto-data` directory and append the two 
lines suggested by `valutod`. `valutod` will suggest a random password for you. Do not use the one from the example above.

After creating the valuto.conf file, the container can be started again.

```bash
docker start valutod
```

Once the container is running, you can execute `valutod` from within the container:

```bash
$ docker exec -it valutod ./valutod getblockcount
```

## Valuto

Find more information about Valuto on [Valuto.io](https://valuto.io).

Also remember to take a look at [the official Github page](https://github.com/valuto).
