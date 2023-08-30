SUMMARY = "Corundum app dma_bench driver kernel module"
SECTION = "kernel"
LICENSE = "MIT & GPLv2"
LIC_FILES_CHKSUM = " \
	file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
	file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit module

# this module uses symbols exported by the mqnic driver and so depends on it
DEPENDS += "kernel-module-mqnic"

# NOTE: As this module uses symbols provided by the mqnic driver, this
#       Makefile expects a variable MQNIC_SYMVERS to point to the desired
#       Module.symvers file of mqnic module. If MQNIC_SYMVERS is unset, the
#       Makefile assumes a default (../mqnic/Module.symvers) which is however
#       not suitable for the PetaLinux/Yocto build enviroment, where the mqnic
#       module is being built in a _separate_ recipe, thus separate WORKDIR.
EXTRA_OEMAKE += "MQNIC_SYMVERS=${STAGING_INCDIR}/kernel-module-mqnic/Module.symvers"

SRC_URI = " \
	file://mqnic_app_dma_bench \
	file://mqnic \
"

S = "${WORKDIR}/mqnic_app_dma_bench"
