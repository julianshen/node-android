# node-android
============

An Android port of node.js. Tested with NDK r9d.

## Build native node.js 
============
* Run "git pull --recurse-submodules" to make sure you have all sources in local
* Switch directory to jni/
* Run "build-node <NDK_PATH>"
* Run "ndk-build" 

## Build demo package
============
You could build demo package with "ant debug"

## NOTE
============
* The JNI bridge is not workable yet. 
