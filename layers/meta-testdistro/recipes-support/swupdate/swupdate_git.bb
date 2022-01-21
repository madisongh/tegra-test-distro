FILESEXTRAPATHS:append := ":${COREBASE}/meta-swupdate/recipes-support/swupdate/swupdate"
require recipes-support/swupdate/swupdate.inc

SRC_REPO = "github.com/madisongh/swupdate.git;protocol=https"
SRCBRANCH = "patches"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH} \
    file://defconfig \
    file://swupdate \
    file://swupdate.sh \
    file://swupdate.service \
    file://swupdate.socket.tmpl \
    file://swupdate-usb.rules \
    file://swupdate-usb@.service \
    file://swupdate-progress.service \
    file://tmpfiles-swupdate.conf \
    file://10-mongoose-args \
    file://90-start-progress \
"
SRCREV = "65ac70055155ad1f666a24a1106986547b012af9"
PV = "2021.99+git${SRCPV}"

CFLAGS += "-Wextra"

LIC_FILES_CHKSUM = "file://LICENSES/GPL-2.0-only.txt;md5=4ee23c52855c222cba72583d301d2338 \
                    file://LICENSES/LGPL-2.1-or-later.txt;md5=4fbd65380cdd255951079008b364516c \
                    file://LICENSES/MIT.txt;md5=838c366f69b72c5df05c96dff79b35f2 \
                    file://LICENSES/BSD-3-Clause.txt;md5=4a1190eac56a9db675d58ebe86eaf50c"
