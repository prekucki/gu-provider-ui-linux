# gu-provider-ui-linux

User Interface for Golem Unlimited provider. Displays appindicator in status bar (tray icon).

# build from sources

```

sudo apt install devscripts meson valac libappindicator3-dev libgee-0.8-dev libsoup2.4-dev libjson-glib-dev
mkdir build_dir
cd build_dir
meson ..
ninja
```


# prepare deb

```
debuild -us -uc --build=binary
```
