# Angular-cli Docker Container

Nothing fancy, just a docker container for angular-cli.

For more info on angular-cli and its commands check out [https://cli.angular.io/](https://cli.angular.io/)

## Usage

```shell
docker run -it --rm \
    -v /etc/localtime:/etc/localtime:ro \
    -v "${PWD}":/workdir \
    --user "$(id -u):$(id -g)" \
    --name angular-cli \
    gruen/angular-cli[:tag] [command]
```

The previous command will mount the current directory and run all ng commands there.
The `--user ...` line makes sure all files are set to the correct owner (assuming the owner should be the current user)
