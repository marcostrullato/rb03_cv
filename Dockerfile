FROM nvcr.io/nvidia/l4t-base:r32.5.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN sh -c "echo '/usr/local/cuda/lib64' >> /etc/ld.so.conf.d/nvidia-tegra.conf"
RUN ldconfig
RUN apt-get install -y build-essential cmake git unzip pkg-config libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libgtk2.0-dev libcanberra-gtk* python3-dev python3-numpy python3-pip libxvidcore-dev libx264-dev libgtk-3-dev libtbb2 libtbb-dev libdc1394-22-dev libv4l-dev v4l-utils libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libavresample-dev libvorbis-dev libxine2-dev libfaac-dev libmp3lame-dev libtheora-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenblas-dev libatlas-base-dev libblas-dev liblapack-dev libeigen3-dev gfortran libhdf5-dev protobuf-compiler libprotobuf-dev libgoogle-glog-dev libgflags-dev
RUN cd ~; wget -O opencv.zip https://github.com/opencv/opencv/archive/4.5.1.zip; wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.5.1.zip; unzip opencv.zip; unzip opencv_contrib.zip
RUN mv ~/opencv-4.5.1 ~/opencv; mv ~/opencv_contrib-4.5.1 ~/opencv_contrib; rm ~/opencv*zip
RUN cd ~/opencv; mkdir build; cd build; cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
-D WITH_OPENCL=OFF \
-D WITH_CUDA=ON \
-D CUDA_ARCH_BIN=5.3 \
-D CUDA_ARCH_PTX="" \
-D WITH_CUDNN=ON \
-D WITH_CUBLAS=ON \
-D ENABLE_FAST_MATH=ON \
-D CUDA_FAST_MATH=1 \
-D OPENCV_DNN_CUDA=ON \
-D ENABLE_NEON=ON \
-D WITH_QT=OFF \
-D WITH_OPENMP=ON \
-D WITH_OPENGL=ON \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_GSTREAMER=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D BUILD_TESTS=OFF \
-D WITH_EIGEN=ON \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D BUILD_NEW_PYTHON_SUPPORT=ON \
-D BUILD_opencv_python3=TRUE \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D HAVE_opencv_python3=ON \
-D BUILD_EXAMPLES=OFF ..; make
RUN cd ~; rm -r /usr/include/opencv4/opencv2; cd ~/opencv/build; make install; ldconfig; make clean; rm -rf ~/opencv; rm -rf ~/opencv_contrib
RUN pip3 install -U jetson-stats
RUN apt install -y libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
RUN pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures pybind11
RUN apt-get -y install python3-wrapt
RUN pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow==1.15.2
RUN apt-get install -y libssl-dev openssl1.0
RUN cd ~; wget https://github.com/Kitware/CMake/releases/download/v3.22.0-rc3/cmake-3.22.0-rc3-linux-aarch64.tar.gz; tar xzf cmake-3.22.0-rc3-linux-aarch64.tar.gz; 
RUN cd ~; git clone https://github.com/AlexeyAB/darknet.git;
RUN mkdir ~/darknet/build_release; cd ~/darknet/build_release; ~/cmake-3.22.0-rc3-linux-aarch64/bin/cmake ..; ~/cmake-3.22.0-rc3-linux-aarch64/bin/cmake --build . --target install --parallel 8
RUN cd ~/darknet; wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v4_pre/yolov4-tiny.weights
RUN apt-get install -y x11-apps
RUN pip3 install nanocamera
RUN pip3 install pillow
