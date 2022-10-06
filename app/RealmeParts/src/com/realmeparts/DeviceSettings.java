/*
 * Copyright (C) 2016 The OmniROM Project
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 */
package com.realmeparts;

import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.hardware.display.DisplayManager;
import android.os.Bundle;
import android.os.VibrationEffect;
import android.os.Vibrator;
import android.util.Log;
import android.view.Display;

import androidx.preference.Preference;
import androidx.preference.PreferenceCategory;
import androidx.preference.PreferenceFragment;
import androidx.preference.PreferenceManager;
import androidx.preference.SwitchPreference;
import androidx.preference.TwoStatePreference;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.text.DecimalFormat;

public class DeviceSettings extends PreferenceFragment
        implements Preference.OnPreferenceChangeListener {

    public static final String KEY_OTG_SWITCH = "otg";
	public static final String KEY_DT2W_SWITCH = "dt2w";
    public static final String KEY_SETTINGS_PREFIX = "device_setting_";
    private static final String ProductName = Utils.ProductName();
	private static TwoStatePreference mDT2WModeSwitch;
    public static DisplayManager mDisplayManager;
    private static NotificationManager mNotificationManager;
    public PreferenceCategory mPreferenceCategory;
    private TwoStatePreference mOTGModeSwitch;

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        final SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this.getContext());
        prefs.edit().putString("ProductName", ProductName).apply();

        addPreferencesFromResource(R.xml.main);

        mOTGModeSwitch = (TwoStatePreference) findPreference(KEY_OTG_SWITCH);
        mOTGModeSwitch.setEnabled(OTGModeSwitch.isSupported());
        mOTGModeSwitch.setChecked(OTGModeSwitch.isCurrentlyEnabled(this.getContext()));
        mOTGModeSwitch.setOnPreferenceChangeListener(new OTGModeSwitch());

		mDT2WModeSwitch = (TwoStatePreference) findPreference(KEY_DT2W_SWITCH);
        mDT2WModeSwitch.setEnabled(DT2WModeSwitch.isSupported());
        mDT2WModeSwitch.setChecked(DT2WModeSwitch.isCurrentlyEnabled(this.getContext()));
        mDT2WModeSwitch.setOnPreferenceChangeListener(new DT2WModeSwitch());
    }
    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {
        return true;
    }
}
