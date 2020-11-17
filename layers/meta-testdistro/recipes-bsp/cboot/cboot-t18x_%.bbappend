PACKAGECONFIG_remove_secureboot = "recovery"
PACKAGECONFIG_append_secureboot = " machine-id"
EXTRA_GLOBAL_DEFINES_append_secureboot = " CONFIG_ENABLE_FUSED_MACHINE_ID=1"
