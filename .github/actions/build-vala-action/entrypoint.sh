#! /bin/bash

debuild -eDEB_BUILD_OPTIONS=noddebs -us -uc --build=binary

ls ../*.deb

