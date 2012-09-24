package org.nodejs.core;

import android.content.Context;
import android.content.res.AssetManager;
import android.content.res.AssetFileDescriptor;

import android.util.Log;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException;

public class NodeJSCore {

	private static final String NODEJS_PATH = "nodejs";

	public static native void run(String mainJS);

	public static void run(Context context, String mainJS) throws IOException {
		File appPath = context.getDir(NODEJS_PATH, Context.MODE_PRIVATE);

		if (!appPath.exists()) {
			appPath.mkdirs();
		}

		// Copy files from assets to app path
		AssetManager assets = context.getAssets();

		//TODO: Easy to cause ANR. Fix it!
		copyAssetFiles(assets, appPath, NODEJS_PATH);

		// Run
		File js = new File(appPath, NODEJS_PATH + "/" + mainJS);
		run(js.toString());
	}

	private static void copyAssetFiles(AssetManager assets, File targetDir,
			String basePath) throws IOException {

		String[] files = assets.list(basePath);

		if (!targetDir.exists()) {
			targetDir.mkdirs();
		}

		if (files.length == 0) {
			// basePath is a file. Copy file
			Log.d("nodejs", "copy file: " + basePath);
			File targetFile = new File(targetDir, basePath);
			InputStream src = assets.open(basePath);
			File path = targetFile.getParentFile();

			if (!path.exists()) {
				path.mkdirs();
			}

			FileOutputStream out = new FileOutputStream(targetFile);
			byte[] buf = new byte[4096];
			int len;

			if ((len = src.read(buf)) > -1) {
				out.write(buf, 0, len);
			}

			src.close();
			out.close();

			return;
		} else {
			for (String file : files) {
				copyAssetFiles(assets, targetDir, basePath + "/" + file);
			}
		}
	}

	static {
		System.loadLibrary("node_jni");
	}
}
