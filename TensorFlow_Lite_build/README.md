# TensorFlow_Mobile_build

## Usage

### script to build TensorFlow Mobile for Android, gen jar and so

* 获取源码
```
git clone --recurse-submodules https://github.com/tensorflow/tensorflow.git
```

注意： --recurse-submodules is necessary to prevent some issues with protobuf compilation.

* 设置环境
```
https://github.com/tensorflow/tensorflow/blob/master/tensorflow/examples/android/README.md 
```

* 添加到最顶层WORKSPACE
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
* build fat library for all architectures
```
./build-tensorflow-mobile.sh
```
* build libraries for specified architectures
```
./build-tensorflow-mobile.sh armeabi-v7a arm64-v8a 
```

#### Configuration
Change variables at the beginning to suit your needs.

#### Build notes

2019-4-11 v1.7.0


# TensorFlow_Lite_build

## Usage

### script to build TensorFlow Lite for Android, gen jar and so

* 获取源码
```
git clone --recurse-submodules https://github.com/tensorflow/tensorflow.git
```

* 设置环境
```
https://www.tensorflow.org/lite/demo_android 
```

* 添加到最顶层WORKSPACE
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
	api_level = 19,
)
```
* build fat library for all architectures
```
./build-tensorflow-lite.sh
```
* build libraries for specified architectures
```
./build-tensorflow-lite.sh armeabi-v7a arm64-v8a
```
#### Configuration
Change variables at the beginning to suit your needs.

#### Build notes

2019-3-4 r1.99

2019-3-12 master

2019-4-2 v2.0.0-alpha0
