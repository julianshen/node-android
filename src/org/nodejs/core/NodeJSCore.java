package org.nodejs.core;

import android.content.Context;
import android.content.res.AssetManager;
import android.content.res.AssetFileDescriptor;

import android.util.Log;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;

public class NodeJSCore {

    private static final String NODEJS_PATH = "nodejs";

    public static native void run(String mainJS) ;

    public static void run(Context context, String mainJS) throws IOException {
        File appPath = context.getDir(NODEJS_PATH, Context.MODE_PRIVATE);
        
        if( !appPath.exists() ) {
            appPath.mkdirs();
        }
  
        //Copy files from assets to app path 
        AssetManager assets = context.getAssets();

        copyAssetFiles(assets, appPath, NODEJS_PATH);
    }

    private static void copyAssetFiles(AssetManager assets, File targetDir, String basePath) 
        throws IOException {
       
        String[] files = assets.list(basePath);

        if(!targetDir.exists()) {
            targetDir.mkdirs();
        }

        if(files.length == 0) {
            //basePath is a file. Copy file
            Log.d("nodejs", "copy file: " + basePath);
            File targetFile = new File(targetDir, basePath);
            AssetFileDescriptor src = assets.openFd(basePath);
            File path = targetFile.getParentFile();

            if(!path.exists()) {
                path.mkdirs();
            }

            FileChannel inChannel = new FileInputStream(src.getFileDescriptor()).getChannel();
            FileChannel outChannel = new FileOutputStream(targetFile).getChannel();
            try {
                 inChannel.transferTo(0, inChannel.size(), outChannel);
            } finally {
                 if (inChannel != null)
                     inChannel.close();
                 if (outChannel != null)
                     outChannel.close();
            }

            return;
        } else {
            for(String file:files) {
                copyAssetFiles(assets, targetDir, basePath + "/" + file);
            }    
        }
    }

    static {
        System.loadLibrary("node_jni");
    }
}
