# Zygote
PRODUCT_SYSTEM_PROPERTIES += \
    persist.device_config.runtime_native.usap_pool_enabled=true

# Iorap
PRODUCT_PRODUCT_PROPERTIES += \
    persist.device_config.runtime_native_boot.iorap_readahead_enable=true

# ZRAM
PRODUCT_SYSTEM_PROPERTIES += \
    ro.zram.mark_idle_delay_mins=60 \
    ro.zram.first_wb_delay_mins=1440 \
    ro.zram.periodic_wb_delay_hours=24

# Performance
PRODUCT_SYSTEM_PROPERTIES += \
    ro.mtk_perf_simple_start_win=1 \
    ro.mtk_perf_fast_start_win=1 \
    ro.mtk_perf_response_time=1

# Surfaceflinger
PRODUCT_SYSTEM_PROPERTIES += \
    debug.sf.latch_unsignaled=1 \
    ro.surface_flinger.max_frame_buffer_acquired_buffers=3 \
    ro.surface_flinger.running_without_sync_framework=true \
    ro.surface_flinger.vsync_event_phase_offset_ns=2000000 \
    ro.surface_flinger.vsync_sf_event_phase_offset_ns=6000000

# Camera
PRODUCT_PRODUCT_PROPERTIES += \
    persist.camera.HAL3.enabled=1 \
    persist.vendor.camera.privapp.list=org.codeaurora.snapcam,com.android.camera,com.google.camera \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.google.camera,org.pixelexperience.faceunlock \
    vendor.camera.aux.packageblacklist=org.telegram.messenger,com.microsoft.teams,com.discord

# IMS
PRODUCT_SYSTEM_PROPERTIES += \
    persist.dbg.volte_avail_ovr=1 \
    persist.dbg.vt_avail_ovr=1 \
    persist.dbg.ims_volte_enable=1 \
    persist.radio.rat_on=combine \
    persist.radio.data_ltd_sys_ind=1 \
    persist.radio.data_con_rprt=1 \
    persist.radio.calls.on.ims=1 \
    persist.vendor.vilte_support=0 \
    persist.vendor.mtk.vilte.enable=0

# Encryption
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.filenames_mode=aes-256-cts \
    ro.crypto.volume.metadata.method=dm-default-key \
    ro.crypto.volume.options=::v2

# Privapp permissions whitelisting
PRODUCT_PRODUCT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Audio
PRODUCT_PRODUCT_PROPERTIES += \
    ro.camera.sound.forced=0 \
    ro.audio.silent=0 \
    ro.config.vc_call_vol_steps=9

# ADB
PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0

# OMX
PRODUCT_SYSTEM_PROPERTIES += \
    debug.stagefright.omx_default_rank.sw-audio=1 \
    media.stagefright.thumbnail.prefer_hw_codecs=true \
    debug.stagefright.omx_default_rank=0 \
    debug.stagefright.ccodec=0

# SOC
PRODUCT_SYSTEM_PROPERTIES += \
    ro.soc.manufacturer=Mediatek \
    ro.soc.model=MT6768

# GBoard
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.ime.kb_pad_port_b=1 \
    ro.com.google.ime.corner_key_r=35

# Hardware Acceleration
PRODUCT_SYSTEM_PROPERTIES += \
    video.accelerate.hw=1 \
    debug.sf.hw=1 \
    debug.performance.tuning=1 \
    debug.egl.profiler=1 \
    debug.egl.hw=1 \
    debug.composition.type=gpu

# Tweak the memory management of the device, enable more background apps.. etc..
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.fha_enable=true \
    ro.sys.fw.bg_apps_limit=32 \
    ro.config.dha_cached_max=16 \
    ro.config.dha_empty_max=42 \
    ro.config.dha_empty_init=32 \
    ro.config.dha_lmk_scale=0.545 \
    ro.config.dha_th_rate=2.3 \
    ro.config.sdha_apps_bg_max=64 \
    ro.config.sdha_apps_bg_min=8

# Dexopt
PRODUCT_SYSTEM_PROPERTIES += \
    pm.dexopt.first-boot=quicken \
    pm.dexopt.bg-dexopt=everything

# Bluetooth
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.device.class_of_device?=90,2,12 \
    bluetooth.hardware.power.operating_voltage_mv=3300 \
    bluetooth.profile.asha.central.enabled?=true \
    bluetooth.profile.avrcp.target.enabled?=true \
    bluetooth.profile.a2dp.source.enabled?=true \
    bluetooth.profile.bas.client.enabled?=true \
    bluetooth.profile.gatt.enabled?=true \
    bluetooth.profile.hfp.ag.enabled?=true \
    bluetooth.profile.hid.device.enabled?=true \
    bluetooth.profile.hid.host.enabled?=true \
    bluetooth.profile.map.server.enabled?=true \
    bluetooth.profile.opp.enabled?=true \
    bluetooth.profile.pan.nap.enabled?=true \
    bluetooth.profile.pan.panu.enabled?=true \
    bluetooth.profile.pbap.server.enabled?=true \
    bluetooth.profile.sap.server.enabled?=true