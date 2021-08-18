inherit tegrasign
EXTRADEPS = ""
EXTRADEPS:secureboot = "${TEGRA_SIGNING_EXTRA_DEPS}"
do_deploy[depends] += "${EXTRADEPS}"

