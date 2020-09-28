#!/bin/sh
#
#  Created by 满达 on 2020/1/8.
#  Copyright © 2020 Beijing Jingdong Shangke Information Technology Co., Ltd. All rights reserved.
#

ARCHS="armeabi armeabi-v7a arm64-v8a x86 x86_64 mips mips64"

BUILDOUT="bazel-build-tensorflow-mobile-android-so-jar_1"
JNILIBS="$BUILDOUT/jniLibs"
LIBS="$BUILDOUT/libs" 
INCS="$BUILDOUT/include" 

# directories
SOURCE="../../tensorflow"

# cd $SOURCE
#     git checkout r2.1
# cd -

COMPILE="y"

if [ "$*" ]
then
	ARCHS="$*"
fi

if [ "$COMPILE" ]
then
	CWD=`pwd`
	for ARCH in $ARCHS
	do
		if [ "$ARCH" = "armeabi" -o "$ARCH" = "armeabi-v7a" \
             -o "$ARCH" = "arm64-v8a" -o "$ARCH" = "x86" \
            -o "$ARCH" = "x86_64" -o "$ARCH" = "mips" -o "$ARCH" = "mips64" ]
        then

		    echo "building $ARCH..."
            #echo "$CWD/$JNILIBS/$ARCH"
            if [ -d "$CWD/$JNILIBS/$ARCH" ]
            then
		        rm -rf  "$CWD/$JNILIBS/$ARCH" 
		        mkdir -p "$CWD/$JNILIBS/$ARCH"
            else
		        mkdir -p "$CWD/$JNILIBS/$ARCH"
            fi

            cd $SOURCE
            bazel clean
            bazel build -c opt //tensorflow/contrib/android:libtensorflow_inference.so \
                   --crosstool_top=//external:android/crosstool \
                   --host_crosstool_top=@bazel_tools//tools/cpp:toolchain \
                   --cxxopt=-std=c++11 \
                   --cpu=$ARCH

		    cd $CWD
            echo "cp $ARCH/libtensorflow_inference.so"
            cp "$CWD/$SOURCE/bazel-bin/tensorflow/contrib/android/libtensorflow_inference.so" "$CWD/$JNILIBS/$ARCH"

        fi
    done
fi

cd $SOURCE
bazel build //tensorflow/contrib/android:android_tensorflow_inference_java
cd $CWD

echo "cp libandroid_tensorflow_inference_java.jar..."
if [ -d "$CWD/$LIBS" ]
then
	rm -rf "$CWD/$LIBS" 
	mkdir -p "$CWD/$LIBS"
else
	mkdir -p "$CWD/$LIBS"
fi
#echo "$SOURCE/bazel-bin/tensorflow/contrib/android/libandroid_tensorflow_inference_java.jar"
cp "$CWD/$SOURCE/bazel-bin/tensorflow/contrib/android/libandroid_tensorflow_inference_java.jar" "$CWD/$LIBS"