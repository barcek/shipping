# shipping

For Dockerfiles using tools from the other repositories.

Currently, the following:

- [rvry](https://github.com/barcek/rvry), run as PID 1, for a configurable sidecar or dummy container for testing
- [deye](https://github.com/barcek/deye), added over a Deno base to be available alongside the usual commands

## Build

The build script takes the name of the tool as the sole argument, parses the Dockerfile in the corresponding directory and builds an image tagged with the tool version and base image identifier.

From the root directory, for the Dockerfiles available:

```shell
./build.sh rvry
./build.sh deye
```

## Tools

### rvry

Source: **[rvry](https://github.com/barcek/rvry)**

The container entrypoint is set to rvry, running the tool as PID 1 with the default behaviour and allowing additional arguments to be passed as usual.

#### Requirements

The tool expects at least a pseudo-tty, and needs stdin open to receive the [sign](https://github.com/barcek/rvry#defaults) key. For both requirements, using `docker run` with no additional arguments to rvry:

```shell
docker run --rm -it rvry
```

The above assumes a generic image name not generated via the build script.

Or with a docker-compose.yaml:

```yaml
services:
  rvry:
    ...
    tty: true
    stdin_open: true
```

Or as part of a Kubernetes spec:

```yaml
spec:
  containers:
  - name: rvry
    ...
    tty: true
    stdin: true
```

#### Arguments

Arguments to rvry can be passed via the `run` command, whether `docker run` or `docker compose run`, with `tty` and `stdin_open` set as above. For example, to print a series of ellipses, each on its own line as if logging:

```shell
docker run --rm -it rvry --mark "...\n" --full
```

```shell
docker compose run --rm rvry --mark "...\n" --full
```

Both of the above also assume a generic image name.

Alternatively, the arguments can be added to a docker-compose.yaml, assuming `tty` and `stdin_open` as above:

```yaml
services:
  rvry:
    ...
    command: ["--mark", "...\n", "--full"]
```

Or a Kubernetes spec, here again assuming `tty` and `stdin`:

```yaml
spec:
  containers:
  - name: rvry
    ...
    args: ["--mark", "...\n", "--full"]
```

### deye

Source: **[deye](https://github.com/barcek/deye)**

The container entrypoint remains the default entrypoint for the base image, making the Deno commands available as usual and allowing for `deye` followed by its usual arguments.

#### Arguments

Arguments to deye can be passed via the `run` command, whether `docker run` or `docker compose run`. For example, to set `--allow all` for a file named index.js in the same directory:

```shell
docker run --rm -v $PWD:/app deye deye all /app/index.js
```

```shell
docker compose run --rm deye deye all /app/index.js
```

Both of the above also assume a generic image name not generated via the build script, and the `compose` example that the volumes needed are defined in the docker-compose.yml.

Alternatively, the arguments can be added there too:

```yaml
services:
  deye:
    ...
    command: ["deye", "all", "app/index.js"]
```

Or in a Kubernetes spec:

```yaml
spec:
  containers:
  - name: deye
    ...
    args: ["deye", "all", "/app/index.js"]
```
