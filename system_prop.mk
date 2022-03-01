# Zygote
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.device_config.runtime_native.usap_pool_enabled=true

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
     persist.bluetooth.bluetooth_audio_hal.disabled=true

# Iorap
PRODUCT_PROPERTY_OVERRIDES += \
    persist.device_config.runtime_native_boot.iorap_readahead_enable=true

# Blurs
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.surface_flinger.supports_background_blur=1

# Performance
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.mtk_perf_simple_start_win=1 \
    ro.mtk_perf_fast_start_win=1 \
    ro.mtk_perf_response_time=1

# Media
PRODUCT_PRODUCT_PROPERTIES += \
    media.stagefright.thumbnail.prefer_hw_codecs=true \
    debug.stagefright.ccodec=0
    
# Surfaceflinger
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    debug.sf.latch_unsignaled=1 \
    ro.surface_flinger.max_frame_buffer_acquired_buffers=3 \
    ro.surface_flinger.vsync_event_phase_offset_ns=2000000 \
    ro.surface_flinger.vsync_sf_event_phase_offset_ns=6000000

# Camera
PRODUCT_PRODUCT_PROPERTIES += \
    persist.camera.HAL3.enabled=1 \
    persist.vendor.camera.privapp.list=org.codeaurora.snapcam,com.android.camera,com.google.camera \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.google.camera,org.pixelexperience.faceunlock \
    vendor.camera.aux.packageblacklist=org.telegram.messenger,com.microsoft.teams,com.discord

# IMS
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.dbg.volte_avail_ovr=1 \
    persist.dbg.vt_avail_ovr=1 \
    persist.dbg.ims_volte_enable=1 \
    persist.radio.rat_on=combine \
    persist.radio.data_ltd_sys_ind=1 \
    persist.radio.data_con_rprt=1 \
    persist.radio.calls.on.ims=1

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
    ro.config.vc_call_vol_steps=7