#include <NodeJSAndroidJNI.h>
#include <jni.h>
#include <string.h>
#include <android/log.h>
#include <stdio.h>
#include "node.h"

//#include "node_android.h"

#define TAG "nodejs"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, TAG, __VA_ARGS__)

void node_start(char *mainScript) {
    int argc = 2;
    char cmds[5 + strlen(mainScript) + 1];
    strcpy(cmds, "node");
    strcpy(cmds + 5 , mainScript);

    char *argv[] = {cmds, cmds + 5};

    LOGD("MAIN SCRIPT: %s", cmds + 5);
    node::Start(argc, argv);
    LOGD("NodeJS End");

}

void JNICALL Java_org_nodejs_core_NodeJSCore_run(JNIEnv *env, jclass clazz, jstring path) {
    const char *script = env->GetStringUTFChars(path, NULL);

    node_start((char *)script);
}
