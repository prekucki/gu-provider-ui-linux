# build environment
FROM ubuntu:19.04
RUN apt-get update && apt-get install -y debhelper meson ninja-build libgtk-3-dev devscripts valac libappindicator3-dev libsoup2.4-dev libjson-glib-dev libglib2.0-dev
