# tegra-test-distro

![Build status](https://builder.madison.systems/badges/testdistro-kirkstone-32-7.svg)

Distro for testing the following:

* Jetson secure boot support with
  * LUKS partition encryption (using the luks-srv TA in L4T)
* Other miscellaneous distribution features, such as
  * Full use of systemd in the initramfs
  * Semi-stateless rootfs using ramdisk overlay
  * Use of an AWS S3 bucket for downloads and sstate mirrors
  * Use of [digsigserver](https://github.com/madisongh/digisgserver) for signing boot artifacts, kernel modules, and Mender artifacts.
  * Cloud-based CI in AWS EC2 using the buildbot-based [autobuilder](https://github.com/madisongh/autobuilder)
  * Use of swupdate, in a basic way, for software updates

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

5. Optional: Install pre-commit hook for commit autosigning using
        $ ./scripts-setup/setup-git-hooks

## Distributions

Only the `testdistro` DISTRO setting is currently tested.  The `testdistro-mender` configuration
is still present, but not actively maintained.


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
