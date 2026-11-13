# Copyright (C) 2025-2026 OrangeAERA Recovery Project
# SPDX-License-Identifier: GPL-3.0-only

FDEVICE="beryl"

aera_get_target_device() {
    local chkdev=""

    if [ -n "$ZSH_VERSION" ]; then
        local current_source="${(%):-%x}"
        chkdev=$(echo "$current_source" | grep -w "$FDEVICE")
    elif [ -n "$BASH_VERSION" ]; then
    	chkdev=$(echo "$BASH_SOURCE" | grep -w "$FDEVICE")
    fi

    if [ -n "$chkdev" ]; then
    	AERA_BUILD_DEVICE="$FDEVICE"
    else
        if [ -n "$BASH_VERSION" ]; then
 		chkdev=$(set | grep BASH_ARGV | grep -w "$FDEVICE")
        elif [ -n "$ZSH_VERSION" ]; then
		chkdev=$(echo "$*" | grep -w "$FDEVICE")
	fi
	[ -n "$chkdev" ] && AERA_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$AERA_BUILD_DEVICE" ]; then
	aera_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$AERA_BUILD_DEVICE" = "$FDEVICE" ]; then

    export LC_ALL="C"
    export ALLOW_MISSING_DEPENDENCIES=true  

    export AERA_VENDOR_BOOT_RECOVERY=1
    export AERA_VANILLA_BUILD=1
    export TARGET_DEVICE_ALT="citrine"
    export AERA_TARGET_DEVICES="beryl,citrine"

    export AERA_VIRTUAL_AB_DEVICE=1
    export AERA_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export AERA_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

    # Set Home directory as data/recovery
    export AERA_USE_DATA_RECOVERY_FOR_SETTINGS=1
    export AERA_USE_UPDATED_MAGISKBOOT=1
    export AERA_COMPRESS_EXECUTABLES=1

    # Binaries & Tools
    export AERA_USE_BASH_SHELL=1
    export AERA_USE_BUSYBOX_BINARY=1
    export AERA_USE_TAR_BINARY=1
    export AERA_USE_SED_BINARY=1
    export AERA_USE_XZ_UTILS=1
    export AERA_USE_ZSTD_BINARY=1
    export AERA_USE_LZ4_BINARY=1
    export AERA_USE_DATE_BINARY=1
    export AERA_REPLACE_TOOLBOX_GETPROP=1

    # OrangeAERA Addons
    export AERA_ENABLE_APP_MANAGER=1
    export AERA_DELETE_AROMAFM=1
    export AERA_DELETE_INITD_ADDON=1

    # to reduce OrangeAERA size
    export AERA_DRASTIC_SIZE_REDUCTION=1

    # KernelSU-Next / SukiSu support
    export AERA_ENABLE_KERNELSU_NEXT_SUPPORT=1
    export AERA_ENABLE_SUKISU_SUPPORT=1
    
    # patchelf 
    export AERA_USE_PATCHELF_BINARY=1
    
    # prevent automated reboot when flashing AERA.zip
    export AERA_INSTALLER_DISABLE_AUTOREBOOT=1
    
    # to fix CANNOT LINK EXECUTIVES & Keystore2 related issues in "Android 16" (ONLY!)
    export AERA_ADD_API_V36_PREBUILTS=2

else
    if [ -z "$AERA_BUILD_DEVICE" ] && [ -z "$BASH_SOURCE" ] && [ -z "$ZSH_VERSION" ]; then
	echo "I: This script requires bash or zsh. Not processing $FDEVICE"
    fi
fi
#
