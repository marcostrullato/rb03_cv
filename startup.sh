docker run  --net=host  --runtime nvidia  --ipc=host   -v /tmp/.X11-unix/:/tmp/.X11-unix/   -v /tmp/argus_socket:/tmp/argus_socket  --cap-add SYS_PTRACE  -e DISPLAY=$DISPLAY  -it  --device=/dev/video0  --privileged  --env="QT_X11_NO_MITSHM=1"  --runtime=nvidia  --volume="$HOME/.Xauthority:/root/.Xauthority"  rb03
