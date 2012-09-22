package org.nodejs.core;

public class NodeJSCore {

    public static native void run(String mainJS) ;

    static {
        System.loadLibrary("node_jni");
    }
}
