DIGSIG_TEMPSTORE_URI = "s3://systems.madison.tempstore"

inherit signing_server

mendersign() {
    if echo "${DIGSIG_SERVER}" | grep -q "127\.0\.0\.1"; then
        uri="file://${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.mender"
        copyback=
    else
        uri="${DIGSIG_TEMPSTORE_URI}/${DISTRO}/`uuidgen`"
        aws s3 cp ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.mender $uri
        copyback="yes"
    fi
    digsig_post sign/mender -F "distro=${DISTRO}" -F "artifact-uri=$uri"
    if [ -n "$copyback" ]; then
        aws s3 cp "$uri" ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.mender
        aws s3 rm "$uri"
    fi
}

IMAGE_CMD:mender:append() {
    mendersign
}

do_image_mender[depends] += "util-linux-native:do_populate_sysroot ${DIGSIG_DEPS}"
do_image_mender[network] = "1"
