CONVERSIONTYPES += "zck"

CONVERSION_CMD:zck = "zck -u -h sha256 -o ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.${type}.zck ${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.${type}"
CONVERSION_DEPENDS_zck = "zchunk-native"
