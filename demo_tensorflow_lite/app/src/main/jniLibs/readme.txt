TensorFlow r1.99

bazel build --cxxopt='--std=c++11' //tensorflow/lite/java:tensorflowlite --crosstool_top=//external:android/crosstool \
--host_crosstool_top=@bazel_tools//tools/cpp:toolchain --cpu=armeabi-v7a