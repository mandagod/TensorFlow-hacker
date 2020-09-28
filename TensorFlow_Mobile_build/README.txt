# TensorFlow_Mobile_build

## Android TensorFlow Mobile build

* 获取源码
```
git clone --recurse-submodules https://github.com/tensorflow/tensorflow.git
```

注意： --recurse-submodules is necessary to prevent some issues with protobuf compilation.

* 设置环境
```
// 依据其中的Bazel源码编译：
// Install Bazel and Android Prerequisites，tensorflow版本必须和bazel版本匹配
// Edit WORKSPACE
https://github.com/tensorflow/tensorflow/tree/r2.1/tensorflow/examples/android/README.md 
```
* 添加到最顶层WORKSPACE(r1.10版本之前)
```
android_sdk_repository (                                                                                                                    
	name = "androidsdk",
	api_level = 23,
	build_tools_version = "26.0.2",
	path = "/Users/manda1/Library/Android/sdk/",
)
android_ndk_repository(
	name = "androidndk",
	path = "/Users/manda1/Library/Android/ndk/ndk-bundle/android-ndk-r14b",
	api_level = 14,
)
```

r1.11版本之后还行./configure进行设置。

* build fat library for all architectures<br>
r2.0以下版本使用bazel-build-tensorflow-mobile-android-so-jar.sh<br>
r2.1以上版本使用bazel-build-tensorflow-mobile-android-so-jar_1.sh

```
./bazel-build-tensorflow-mobile-android-so-jar_1.sh
```
* build libraries for specified architectures
```
./bazel-build-tensorflow-mobile-android-so-jar_1.sh armeabi-v7a arm64-v8a 
```