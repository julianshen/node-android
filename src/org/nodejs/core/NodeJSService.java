package org.nodejs.core;

import java.io.IOException;

import android.app.Service;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ServiceInfo;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

public class NodeJSService extends Service {

	private static final String TAG = "nodejs-service";

	@Override
	public IBinder onBind(Intent intent) {
		return null;
	}

	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		PackageManager pm = getPackageManager();
		ComponentName component = new ComponentName(this, this.getClass());
		ServiceInfo info = null;

		Log.d(TAG, component.toString());

		try {
			info = pm.getServiceInfo(component, PackageManager.GET_META_DATA);
		} catch (NameNotFoundException e) {
			e.printStackTrace();
			return START_NOT_STICKY;
		}

		Bundle metaData = info.metaData;

		String scriptName = metaData.getString("script");

		if (scriptName == null) {
			Log.e(TAG, "Script <" + scriptName
					+ "> is not set as service's meta");
			return START_NOT_STICKY;
		}

		try {
			NodeJSCore.run(this, scriptName);
		} catch (IOException e) {
			e.printStackTrace();
			return START_NOT_STICKY;
		}

		return START_STICKY;
	}

}
