# YatCPU Docker

This docker image contains the neccessary dependencies to run the [YatCPU](https://github.com/howardlau1999/yatcpu). A copy of code is located at `/root/yatcpu` inside the container. You may need to run `git pull` as it may not be the latest code.

## Run

```bash
docker run -it --rm -v howardlau1999/yatcpu:latest
sbt test
```

If you prefer to modify your code outside the container, just mount the folder on the host machine.

```bash
docker run -it --rm -v /path/to/yatcpu:/root/yatcpu howardlau1999/yatcpu:latest
```