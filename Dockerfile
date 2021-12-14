FROM nvcr.io/nvidia/l4t-base:r32.5.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN sh -c "echo '/usr/local/cuda/lib64' >> /etc/ld.so.conf.d/nvidia-tegra.conf"
RUN ldconfig
RUN apt-get install -y build-essential cmake git unzip pkg-config libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libgtk2.0-dev libcanberra-gtk* python3-dev python3-numpy python3-pip libxvidcore-dev libx264-dev libgtk-3-dev libtbb2 libtbb-dev libdc1394-22-dev libv4l-dev v4l-utils libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libavresample-dev libvorbis-dev libxine2-dev libfaac-dev libmp3lame-dev libtheora-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenblas-dev libatlas-base-dev libblas-dev liblapack-dev libeigen3-dev gfortran libhdf5-dev protobuf-compiler libprotobuf-dev libgoogle-glog-dev libgflags-dev

RUN cd /tmp; wget https://raw.githubusercontent.com/marcostrullato/Install-OpenCV-Jetson-Nano/main/OpenCV-4-5-4.sh; chmod 755 /tmp/OpenCV-4-5-4.sh; /tmp/OpenCV-4-5-4.sh; rm -f /tmp/OpenCV-4-5-4.sh; rm -fr ~/opencv; rm -fr ~/opencv_contrib

#RUN pip3 install -U jetson-stats
#RUN apt install -y libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
#RUN pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures pybind11
#RUN apt-get -y install python3-wrapt
#RUN pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow==1.15.2
#RUN apt-get install -y libssl-dev openssl1.0
#RUN cd ~; wget https://github.com/Kitware/CMake/releases/download/v3.22.0-rc3/cmake-3.22.0-rc3-linux-aarch64.tar.gz; tar xzf cmake-3.22.0-rc3-linux-aarch64.tar.gz; 
#RUN cd ~; git clone https://github.com/AlexeyAB/darknet.git;
#RUN mkdir ~/darknet/build_release; cd ~/darknet/build_release; ~/cmake-3.22.0-rc3-linux-aarch64/bin/cmake ..; ~/cmake-3.22.0-rc3-linux-aarch64/bin/cmake --build . --target install --parallel 8
#RUN cd ~/darknet; wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v4_pre/yolov4-tiny.weights
#RUN apt-get install -y x11-apps
#RUN pip3 install nanocamera
#RUN pip3 install pillow
