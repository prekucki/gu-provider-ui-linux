# gu-provider-ui-linux

User Interface for Golem Unlimited provider. Displays appindicator in status bar (tray icon).

## Building Using Docker (Recommended)

### Step 1: Create Dockerfile

```
FROM prekucki/python3:glibc-2.19
RUN pip3 install --upgrade pip
RUN pip3 install meson
RUN pip3 install ninja
RUN apt-get update && apt-get install -y libgtk-3-dev devscripts valac libappindicator3-dev libsoup2.4-dev libjson-glib-dev libglib2.0-dev
# required by meson
RUN ln -s -f /usr/bin/python3.6 /usr/bin/python3

# go to the directory with sources and run:
# docker run -it --rm -u $UID:$UID -v $(dirname $PWD):/src -w /src/$(basename $PWD) vala2deb bash -c '(debuild -us -uc --build=binary)'
```

### Step 2: Build Docker Image

`docker build . -t vala2deb`

### Step 3: Build Binary

Go to the gu-provider-ui-linux directory. Make sure that there is a "build" directory inside it, then run:

`docker run -it --rm -u $UID:$UID -v $(dirname $PWD):/src -w /src/$(basename $PWD) vala2deb bash -c '(debuild -us -uc --build=binary)'`

## Building From Sources

```
sudo apt install devscripts meson valac libappindicator3-dev libsoup2.4-dev libjson-glib-dev libglib2.0-dev
mkdir build_dir
cd build_dir
meson ..
ninja
```

### Debian Package

```
debuild -us -uc --build=binary
```
