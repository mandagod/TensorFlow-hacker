#!/bin/sh

# generate libtensorflow_inference.so and libtensorflow-core.a

ARCHS="armeabi armeabi-v7a arm64-v8a x86 x86_64 mips mips64"

BUILD_TYPE="libtensorflow-core.a"
#BUILD_TYPE="libtensorflow_inference.so"
#BUILD_TYPE="tensorflow-core.so"

BUILDOUT="build-out-mobile"
JNILIBS="jniLibs"
LIBS="libs" 
INCS="include" 

# directories
SOURCE="../../tensorflow"

export NDK_ROOT=/Users/manda1/Library/Android/ndk/ndk-bundle/android-ndk-r14b
cd $SOURCE
git checkout v1.7.0 -b v1.7.0
make -f tensorflow/contrib/makefile/Makefile clean
cd -

GRAPH=~/graphs
#--------------------------------------------------------------------------
#if [ -d "$GRAPH" ]
#then
#    echo "~graphs exist"
#    rm -rf ~/graphs/inception
#    unzip ~/graphs/inception.zip -d ~/graphs/inception
#else
#mkdir -p ~/graphs
#curl -o ~/graphs/inception.zip \
# https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip \
# && unzip ~/graphs/inception.zip -d ~/graphs/inception
#fi
#--------------------------------------------------------------------------

COMPILE="y"

DOWNLOADS="tensorflow/contrib/makefile/downloads"
cd $SOURCE
# you make header changes you will need to run this command to recompile cleanly
#make -f tensorflow/contrib/makefile/Makefile clean
#if [ ! -d $DOWNLOADS ]
#then
    # You should only need to do this step once
#    tensorflow/contrib/makefile/download_dependencies.sh
#    # ./tensorflow/contrib/makefile/downloads/nsync/platform/posix/make.common
#    # change the flag cr as scr
#fi
# very clean it
#rm -rf tensorflow/contrib/makefile/downloads
#rm -rf tensorflow/contrib/makefile/gen
cd -

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
            if [ -d "$CWD/$BUILDOUT/$ARCH/$JNILIBS" ]
            then
		        rm -rf  "$CWD/$BUILDOUT/$ARCH/$JNILIBS" 
		        mkdir -p "$CWD/$BUILDOUT/$ARCH/$JNILIBS"
            else
		        mkdir -p "$CWD/$BUILDOUT/$ARCH/$JNILIBS"
            fi
            if [ -d "$CWD/$BUILDOUT/$ARCH/$LIBS" ]
            then
		        rm -rf  "$CWD/$BUILDOUT/$ARCH/$LIBS" 
		        mkdir -p "$CWD/$BUILDOUT/$ARCH/$LIBS"
            else
		        mkdir -p "$CWD/$BUILDOUT/$ARCH/$LIBS"
            fi
            if [ -d "$CWD/$BUILDOUT/$ARCH/$INCS" ]
            then
		        rm -rf  "$CWD/$BUILDOUT/$ARCH/$INCS" 
		        mkdir -p "$CWD/$BUILDOUT/$ARCH/$INCS"
            else
		        mkdir -p "$CWD/$BUILDOUT/$ARCH/$INCS"
            fi

            cd $SOURCE
            #tensorflow/contrib/makefile/compile_android_protobuf.sh -c -a $ARCH
        
            #export HOST_NSYNC_LIB=`tensorflow/contrib/makefile/compile_nsync.sh`
            #export TARGET_NSYNC_LIB=`CC_PREFIX="${CC_PREFIX}" NDK_ROOT="${NDK_ROOT}" \
            #          tensorflow/contrib/makefile/compile_nsync.sh -t android -a $ARCH`
        
            #make -f tensorflow/contrib/makefile/Makefile TARGET=ANDROID ANDROID_ARCH=$ARCH
            if [ $BUILD_TYPE == "libtensorflow-core.a" ]
            then
            tensorflow/contrib/makefile/build_all_android.sh \
                -t \
                all \
                -a  $ARCH \
                -E
		    cd $CWD
            echo "cp $ARCH/libtensorflow-core.a"
            cp -r "$CWD/$SOURCE/tensorflow/contrib/makefile/gen/lib/android_$ARCH/libtensorflow-core.a" "$CWD/$BUILDOUT/$ARCH/$JNILIBS"
            
            elif [ $BUILD_TYPE == "libtensorflow_inference.so" ]
            then
            tensorflow/contrib/makefile/build_all_android.sh \
                -s \
                tensorflow/contrib/makefile/sub_makefiles/android/Makefile.in \
                -t \
                libtensorflow_inference.so libtensorflow_demo.so all \
                -a  $ARCH \
                -E
		    cd $CWD
            echo "cp $ARCH/libtensorflow_inference.so"
            cp -r "$CWD/$SOURCE/tensorflow/contrib/makefile/gen/lib/android_$ARCH/libtensorflow_inference.so" "$CWD/$BUILDOUT/$ARCH/$JNILIBS"

            elif [ $BUILD_TYPE == "tensorflow-core.so" ] 
            then
            tensorflow/contrib/makefile/build_all_android.sh \
                -s \
                tensorflow/contrib/makefile/sub_makefiles/so/Makefile.in \
                -t \
                tensorflow-core.so all \
                -a  $ARCH \
                -E
		    cd $CWD
            echo "cp $ARCH/libtensorflow-core.so"
            cp -r "$CWD/$SOURCE/tensorflow/contrib/makefile/gen/lib/android_$ARCH/libtensorflow-core.so" "$CWD/$BUILDOUT/$ARCH/$JNILIBS"

            fi
        fi
    done
fi
