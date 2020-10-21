# tegra-test-distro

![Build status](https://builder.madison.systems/badges/testdistro-dunfell.svg)

Distro for testing the following:

* meta-tegra platforms
* meta-mender-core/meta-mender-tegra integration
* Jetson secure boot support with
  * LUKS partition encryption
  * The [keystore](https://github.com/madisongh/keystore) Trusted Application
* Other miscellaneous distribution features, such as
  * Full use of systemd in the initramfs
  * Semi-stateless rootfs using ramdisk overlay
  * Use of an AWS S3 bucket for downloads and sstate mirrors
  * Use of [digsigserver](https://github.com/madisongh/digisgserver) for signing boot artifacts, kernel modules, and Mender artifacts.
  * Cloud-based CI in AWS EC2 using the buildbot-based [autobuilder](https://github.com/madisongh/autobuilder)

This test distro is derived from the OE4T
[reference/demo distro](https://github.com/OE4T/tegra-demo-distro).
Some features and fixes implemented here are for upstreaming to that
repository.

You are welcome to fork this repository for your own use; however,
you may find that:

* branches are frequently rebased on top of changes in the OE4T upstream,
losing history
* builds may get broken as new features are integrated (check the CI
status indicator on commits)

I recommend using the OE4T repository as a base instead.

## Prerequisites and setup instructions

Prerequisites and setup are the same as for the OE4T [reference/demo distro](https://github.com/OE4T/tegra-demo-distro).

If you intend to use S3 as a mirror for downloads and/or sstate, you should also install the `python3-boto3`
and `python3-s3transfer` packages on your build host for faster transfers, and have suitable AWS CLI
configuration and credentials available for access to your S3 bucket during builds.


4. Optional: Install pre-commit hook for commit autosigning using
        $ ./scripts-setup/setup-git-hooks

## Distributions

Use the `--distro` option with `setup-env` to specify a distribution for your build,
or customize the DISTRO setting in your `$BUILDDIR/conf/local.conf` to reference one
of the supported distributions.

Currently supported distributions are listed below:


| Distribution name | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| testdistro        | Default distro used to demonstrate/test meta-tegra features   |
| testdistro-mender | Adds [mender](https://www.mender.io/) OTA support             |
| tegrademo         | from upstream OE4T repository; not regularly tested here      |
| tegrademo-mender  | from upstream OE4T repository; not regularly tested here      |

### tegrademo-mender

The tegrademo-mender distro demonstrates [mender](https://www.mender.io/) OTA update
support with customizations on the tegrademo distribution including:

1. Dual A/B rootfs support with read-only-rootfs.
2. Integration with cboot and [tegra-boot-tools](https://github.com/OE4T/tegra-boot-tools)
 to support persistent systemd machine-id settings on read only rootfs.
3. Boot slot and rootfs partition synchronization through boot tools and bootloader
integration.

The synchronization of boot slot and root filesystem partition is more complicated to
manage and test with via u-boot (see [this issue](https://github.com/BoulderAI/meta-mender-community/pull/1#issue-516955713)
for detail).  For this reason, the tegrademo-mender distribution defaults to use the
cboot bootloader on Jetson TX2, instead of the default u-boot bootloader used by
meta-tegra.  If you need to use a different bootloader you can customize the setting
of `PREFERRED_PROVIDER_virtual/bootloader_tegra186` in your distro layer.

## Images

The `testdistro` distros include the following image recipes, which are based on
the image recipes in the OE4T demo distro with some additions for testing and
troubleshooting.

| Recipe name       | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| demo-image-base   | Basic image with no graphics                                  |
| demo-image-egl    | Base with DRM/EGL graphics, no window manager                 |
| demo-image-sato   | X11 image with Sato UI                                        |
| demo-image-weston | Wayland with Weston compositor                                |
| demo-image-full   | Sato image plus nvidia-docker, openCV, multimedia API samples |

# Contributing

Please see the contributor wiki page at [this link](https://github.com/OE4T/meta-tegra/wiki/OE4T-Contributor-Guide).
Contributions are welcome!

