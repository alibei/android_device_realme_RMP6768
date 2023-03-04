/*
   Copyright (c) 2015, The Linux Foundation. All rights reserved.
   Copyright (C) 2016 The CyanogenMod Project.
   Copyright (C) 2019 The LineageOS Project.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <fstream>
#include <string.h>
#include <sys/sysinfo.h>
#include <unistd.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>
#include <android-base/properties.h>
#include "property_service.h"
#include "vendor_init.h"
#include <fs_mgr_dm_linear.h>

using android::base::GetProperty;
using android::base::SetProperty;
using std::string;

void property_override(string prop, string value)
{
    auto pi = (prop_info*) __system_property_find(prop.c_str());

    if (pi != nullptr)
        __system_property_update(pi, value.c_str(), value.size());
    else
        __system_property_add(prop.c_str(), prop.size(), value.c_str(), value.size());
}

void property_override_triple(char const product_prop[], char const system_prop[], char const vendor_prop[],
    char const value[])
{
    property_override(product_prop, value);
    property_override(system_prop, value);
    property_override(vendor_prop, value);
}

void dalvik_load_properties()
{
    struct sysinfo sys;
    sysinfo(&sys);
    // Set dalvik heap configuration
    string heapstartsize, heapgrowthlimit, heapsize, heapminfree,
			heapmaxfree, heaptargetutilization;
   if (sys.totalram > 5072ull * 1024 * 1024) {
        // from - phone-xhdpi-6144-dalvik-heap.mk
        heapstartsize = "16m";
        heapgrowthlimit = "256m";
        heapsize = "512m";
        heaptargetutilization = "0.5";
        heapminfree = "8m";
        heapmaxfree = "32m";
    } else if (sys.totalram > 3072ull * 1024 * 1024) {
        // from - phone-xhdpi-4096-dalvik-heap.mk
        heapstartsize = "8m";
        heapgrowthlimit = "192m";
        heapsize = "512m";
        heaptargetutilization = "0.6";
        heapminfree = "8m";
        heapmaxfree = "16m";
    } else {
        // from - phone-xhdpi-2048-dalvik-heap.mk
        heapstartsize = "8m";
        heapgrowthlimit = "192m";
        heapsize = "512m";
        heaptargetutilization = "0.75";
        heapminfree = "512k";
        heapmaxfree = "8m";
        // Reduce memory footprint
        property_override("ro.config.avoid_gfx_accel", "true");
    }
    property_override("dalvik.vm.heapstartsize", heapstartsize);
    property_override("dalvik.vm.heapgrowthlimit", heapgrowthlimit);
    property_override("dalvik.vm.heapsize", heapsize);
    property_override("dalvik.vm.heaptargetutilization", heaptargetutilization);
    property_override("dalvik.vm.heapminfree", heapminfree);
    property_override("dalvik.vm.heapmaxfree", heapmaxfree);
}

void device_load_properties()
{
    struct sysinfo sys;
    sysinfo(&sys);
    string model;
    string device;
    string sku;
    string region = GetProperty("ro.boot.product.regionmark", "");
    string hw = GetProperty("ro.boot.hwversion", "");
    if (hw == "0" || hw == "1" || hw == "2") {
        model = "Realme Pad LTE";
        if (region == "EEA") {
            device = "RMP2102EEA";
        }
        else if (region == "RU") {
            device = "RMP2102RU";
        }
        else if (region == "TR") {
            device = "RMP2102TR";
        }
        else {
            device = "RMP2102";
        }
    }
    else if (hw == "3" || hw == "4" || hw == "5") {
        model = "Realme Pad WiFi";
        if (region == "EEA") {
            device = "RMP2103EEA";
        }
        else if (region == "RU") {
            device = "RMP2103RU";
        }
        else if (region == "TR") {
            device = "RMP2103TR";
        }
        else {
            device = "RMP2103"; 
        }
    }
    else {
        model = "Realme Pad";
        device = "RMP6768";
    }
    // Override all partitions' props
    string prop_partitions[] = { "", "odm.", "product.", "system.",
					"system_ext.", "bootimage.", "vendor." };
    for (const string &prop : prop_partitions) {
        property_override(string("ro.product.") + prop + string("name"), device);
        property_override(string("ro.product.") + prop + string("device"), device);
        property_override(string("ro.product.") + prop + string("model"), model);
	    property_override(string("ro.") + prop + string("build.product"), device);
    }
}

void vendor_load_properties()
{
    device_load_properties();
    dalvik_load_properties();

    #ifdef __ANDROID_RECOVERY__
    std::string buildtype = GetProperty("ro.build.type", "userdebug");
    property_override("ro.product.device", "RMP6768");
    property_override("ro.build.product", "RMP6768");
    if (buildtype != "user") {
        property_override("ro.debuggable", "1");
        property_override("ro.adb.secure.recovery", "0");
    }
    #endif
}
