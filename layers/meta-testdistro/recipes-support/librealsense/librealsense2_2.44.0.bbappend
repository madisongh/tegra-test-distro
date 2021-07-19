inherit cuda

SRC_URI += "\
    file://0001-Use-pre-fetched-firmware-files.patch \
    file://0002-Internet-connectivity-irrelevant-for-pre-fetched-fir.patch \
    https://librealsense.intel.com/Releases/RS4xx/FW/D4XX_FW_Image-5.12.12.100.bin;name=d4xx-fw \
    https://librealsense.intel.com/Releases/SR300/FW/SR3XX_FW_Image-3.26.1.0.bin;name=sr3xx-fw \
    https://librealsense.intel.com/Releases/TM2/FW/target/0.2.0.951/target-0.2.0.951.mvcmd;name=t26x-fw \
    https://librealsense.intel.com/Releases/L5xx/FW/L5XX_FW_Image-1.5.5.0.bin;name=l5xx-fw \
"
SRC_URI[d4xx-fw.sha256sum] = "1ac04368a3a38947e4d54cd7adcd1635e56d9bb282de7ca9d96c57b98ce6965b"
SRC_URI[sr3xx-fw.sha256sum] = "c4ac2144df13c3a64fca9d16c175595c903e6e45f02f0f238630a223b07c14d1"
SRC_URI[t26x-fw.sha256sum] = "0265fd111611908b822cdaf4a3fe5b631c50539b2805d2f364c498aa71c007c0"
SRC_URI[l5xx-fw.sha256sum] = "5cbbb52c604b41fa5d09f9222d0248a285e10ef3db637f6b2b0803ca8f75117b"

EXTRA_OECMAKE_append_cuda = " -DBUILD_WITH_CUDA:BOOL=ON"

do_configure_prepend() {
    for f in ${WORKDIR}/*FW_Image*bin ${WORKDIR}/target*mvcmd; do
        ln -sf $f ${S}/common/fw/
    done
}
