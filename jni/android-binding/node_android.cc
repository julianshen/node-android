// Copyright Joyent, Inc. and other Node contributors.
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
// NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.


#include "node.h"
#include "node_android.h"

#include "v8.h"

#include <errno.h>
#include <string.h>
//#include <android/log.h>

//#define ALOG(LEVEL, TAG, MSG) ((void)__android_log_print(LEVEL, TAG, MSG))

#define TYPE_ERROR(msg) \
    ThrowException(Exception::TypeError(String::New(msg)));

namespace node {

using namespace v8;


static Handle<Value> Log(const Arguments& args) {                     
  HandleScope scope;                                                   
                                                                      
  int len = args.Length();  
  if (len < 1) return TYPE_ERROR("level required");
  if (len < 2) return TYPE_ERROR("tag required");                      
  if (len < 3) return TYPE_ERROR("message required");
  if (!args[0]->IsInt32()) return TYPE_ERROR("level must be an integer");
  if (!args[1]->IsString()) return TYPE_ERROR("tag must be a string"); 

  const int level = args[0]->Int32Value();
  String::Utf8Value tag(args[1]);                                     
  String::Utf8Value msg(args[2]);                                     
  
  //ALOG(level, *tag, *msg);                                                 
                                                                   
  return Undefined();                                             
}

void Android::Initialize(v8::Handle<v8::Object> target) {
  HandleScope scope;

  NODE_SET_METHOD(target, "log", Log);
  NODE_DEFINE_CONSTANT(target, ANDROID_LOG_VERBOSE);
  NODE_DEFINE_CONSTANT(target, ANDROID_LOG_DEBUG);
  NODE_DEFINE_CONSTANT(target, ANDROID_LOG_INFO);
  NODE_DEFINE_CONSTANT(target, ANDROID_LOG_WARN);
  NODE_DEFINE_CONSTANT(target, ANDROID_LOG_ERROR);
}

}  // namespace node

NODE_MODULE(node_android, node::Android::Initialize)

