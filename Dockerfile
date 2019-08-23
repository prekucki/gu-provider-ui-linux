# build environment
FROM prekucki/python3:glibc-2.19
RUN pip3 install --upgrade pip
RUN pip3 install meson
RUN pip3 install ninja
RUN apt-get update && apt-get install -y libgtk-3-dev devscripts valac libappindicator3-dev libsoup2.4-dev libjson-glib-dev libglib2.0-dev
# required by meson
RUN ln -s -f /usr/bin/python3.6 /usr/bin/python3
