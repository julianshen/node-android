package org.nodejs.core;

public class NodeJSCore {

    public static native void run() ;

    static {
        System.loadLibrary("node_jni");
    }
}
