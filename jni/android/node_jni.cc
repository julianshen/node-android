#include <NodeJSAndroidJNI.h>
#include <jni.h>
#include <android/log.h>
#include <stdio.h>
#include "node.h"

#define TAG "nodejs"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, TAG, __VA_ARGS__)

void JNICALL Java_org_nodejs_core_NodeJSCore_run(JNIEnv *env, jclass clazz, jstring path) {
    const char *str = env->GetStringUTFChars(path, NULL);
    int argc = 2;
    char *argv[] = {"node", (char *)str};

    LOGD("MAIN SCRIPT: %s", str);
    node::Start(argc, argv);
}
