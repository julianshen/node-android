package org.nodejs.core;


public class NodeJSCore {

	private static final String TAG = "nodejs-core";

	public static native void run(String mainJS);

	static {
		System.loadLibrary("nodeJNI");
	}
}
