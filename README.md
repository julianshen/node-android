# node-android
============

An Android port of node.js. Tested with NDK r9d.

## Build native node.js 
============
* Run "git pull --recurse-submodules" to make sure you have all sources in local
* Clone the latest node.js into jni/node-latest
* Switch directory to jni/
* Run "build-node &lt;NDK_PATH&gt;"
* Run "ndk-build" 

## Build demo package
============
You could build demo package with "ant debug"


