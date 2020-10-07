#!/bin/sh
#ToDo - set differenc OpenCL
export CUR_DIR=$PWD
echo $OPENCV_TEST_DATA_PATH
export OPENCV_TEST_DATA_PATH=$(echo ~/sdk/src/opencv/opencv_extra/testdata)
echo $OPENCV_TEST_DATA_PATH
cd ~/sdk/src/opencv/opencv_extra/testdata/dnn
pwd
#crash on arm - usw wget instead
#python3 ./download_models.py YOLOv4-tiny
#python3 ./download_models.py YOLOv4

if test -f "./yolov4.weights"; then
echo "YOLOv4 weights is OK"
else
    wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights
fi
if test -f "./yolov4-tiny.weights"; then
echo "YOLOv4-tiny weights is OK"
else
wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v4_pre/yolov4-tiny.weights
fi

cd $CUR_DIR
pwd
ls
~/sdk/build/opencv/bin/opencv_perf_dnn --gtest_filter=Layer_Slice.YOLOv4*:DNNTestNetwork.YOLOv4* --gtest_output=xml
 ~/sdk/src/opencv/opencv/modules/ts/misc/report.py *.xml -c median > ../res/result.txt
rm ./test_detail.xml
less ../res/result.txt
