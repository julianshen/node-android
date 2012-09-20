var binding = process.binding('android');

function log(level, args) {
    var tag = args[0];
    var len = args.length;
    var objs = [];

    for(var i = 1; i < len; i++) {
       objs.push(args[i]);
    }
    var msg = objs.join(' ');

    binding.log(level, tag, msg);
}

var alog = {
    v: function() {
        log(binding.ANDROID_LOG_VERBOSE, arguments);
    },
    d: function() {
        log(binding.ANDROID_LOG_DEBUG, arguments);
    },
    i: function() {
        log(binding.ANDROID_LOG_INFO, arguments);
    },
    w: function() {
        log(binding.ANDROID_LOG_WARN, arguments);
    },
    e: function() {
        log(binding.ANDROID_LOG_ERROR, arguments);
    }
};

global.alog = alog;
