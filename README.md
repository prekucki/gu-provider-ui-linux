# gu-provider-ui-linux

User Interface for Golem Unlimited Provider. Displays app indicator (tray icon) in the status bar.

## Building Using Docker (Recommended)

### Step 1: Build Docker Image

Dockerfile is located in the main source directory. Enter:

`docker build . -t vala2deb`

### Step 2: Build Binary

Go to the gu-provider-ui-linux directory. Run:

`mkdir deb` (this directory must exists and must be writeable)

`docker run -i --rm -u $UID:$GID -v $PWD/deb:/src -v $PWD:/src/build -w /src/build vala2deb bash -c '(debuild -eDEB_BUILD_OPTIONS=noddebs -us -uc --build=binary)'`

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
