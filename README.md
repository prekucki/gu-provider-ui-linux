# gu-provider-ui-linux

User Interface for Golem Unlimited provider. Displays appindicator in status bar (tray icon).

# Build With Docker (Recommended)

## Step 1: Create Dockerfile

```
FROM debian:oldstable
RUN apt-get update && apt-get install -y libgtk-3-dev devscripts meson valac libappindicator3-dev libsoup2.4-dev libjson-glib-dev libglib2.0-dev
```

## Step 2: Build Docker Image

`docker build . -t vala2deb`

## Step 3: Build Binary

Go to the gu-provider-ui-linux directory. Make sure that there is a "build" directory inside it, then run:

`docker run -it --rm -u $UID:$UID -v $PWD:/src -v $PWD/build:/build -w /build vala2deb bash -c '(meson /src ; ninja)'`

# Build From Sources

```
sudo apt install devscripts meson valac libappindicator3-dev libsoup2.4-dev libjson-glib-dev libglib2.0-dev
mkdir build_dir
cd build_dir
meson ..
ninja
```

# Build Debian Package

```
debuild -us -uc --build=binary
```
