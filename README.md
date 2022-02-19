# YatCPU Docker

This docker image contains the neccessary dependencies to run the [YatCPU](https://github.com/howardlau1999/yatcpu). A copy of code is located at `/root/yatcpu` inside the container. You may need to run `git pull` as it may not be the latest code.

## Run

```bash
docker run -it --rm howardlau1999/yatcpu:latest
sbt test
```

Please note that if you don't mount a host folder, all changes made in the container will be lost once it is stopped. 

To persist your changes, please clone the repository first and mount it in the container every time you run the container.

```bash
git clone https://github.com/howardlau1999/yatcpu
docker run -it --rm -v yatcpu:/root/yatcpu howardlau1999/yatcpu:latest
```
