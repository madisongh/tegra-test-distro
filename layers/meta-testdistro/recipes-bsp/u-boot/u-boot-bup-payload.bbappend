inherit tegrasign
EXTRADEPS = ""
EXTRADEPS_secureboot = "${TEGRA_SIGNING_EXTRA_DEPS}"
do_deploy[depends] += "${EXTRADEPS}"

