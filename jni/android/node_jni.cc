#include <NodeJSAndroidJNI.h>
#include "node.h"

void JNICALL Java_org_nodejs_core_NodeJSCore_run(JNIEnv *env, jclass clazz) {
    int argc = 2;
    char *argv[] = {"node", "/sdcard/demo.js"};
 
    node::Start(argc, argv);

}
