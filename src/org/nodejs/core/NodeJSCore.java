package org.nodejs.core;

import android.content.Context;
import android.content.res.AssetManager;

import java.io.File;

public class NodeJSCore {

    private static final String PACKAGE_EXT = ".zip";

    public static native void run(String mainJS) ;

    public static void run(Context context, String jsPackage) {
        File appPath = new File(context.getDir("js", Context.MODE_PRIVATE), jsPackage);
        
        if( !appPath.exists() ) {
            appPath.mkdirs();
        }
  
        //Extract files from assets to app path 
        AssetManager assets = context.getAssets();
    }

    static {
        System.loadLibrary("node_jni");
    }
}
