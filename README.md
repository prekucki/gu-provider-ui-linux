# gu-provider-ui-linux


# build from sources

```
sudo apt install devscripts meson valac libappindicator3-dev libgee-0.8-dev libsoup2.4-dev libjson-glib-dev
mkdir build
meson build
```


# prepare deb 
```
debuild -us -uc --build=binary
```
