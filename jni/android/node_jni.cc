#include <NodeJSAndroidJNI.h>
#include <jni.h>
#include <android/log.h>
#include <stdio.h>
#include "node.h"
#include "node_android.h"

#define TAG "nodejs"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, TAG, __VA_ARGS__)

void JNICALL Java_org_nodejs_core_NodeJSCore_run(JNIEnv *env, jclass clazz, jstring path) {
    const char *script = env->GetStringUTFChars(path, NULL);

    LOGD("MAIN SCRIPT: %s", script);
    node::AndroidStart((char *)script);
    LOGD("NodeJS End");
}
