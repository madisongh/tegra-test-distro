inherit signing_server

PACKAGE_DEPENDS += "${@' '.join([dep.split(':')[0] for dep in d.getVar('DIGSIG_DEPS').split()])}"
PACKAGEBUILDPKGD:append:secureboot = " sign_modules"

PKGD_SIGNED = "${WORKDIR}/package-signed"

sign_modules() {
    tar -C ${PKGD} -c -z -f ${PKGD_SIGNED}/modules-in.tar.gz ${@d.getVar('nonarch_base_libdir')[1:]}/modules
    digsig_post sign/modules -F "machine=${MACHINE}" -F "hashalg=sha512" -F "artifact=@${PKGD_SIGNED}/modules-in.tar.gz" --output ${PKGD_SIGNED}/modules-out.tar.gz
    tar -C ${PKGD} -x --no-same-owner -f ${PKGD_SIGNED}/modules-out.tar.gz ./${@d.getVar('nonarch_base_libdir')[1:]}/modules
}
sign_modules[cleandirs] = "${PKGD_SIGNED}"
sign_modules[dirs] = "${PKGD_SIGNED}"
