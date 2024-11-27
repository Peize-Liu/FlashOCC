docker run -it --gpus all --net=host \
    --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
    --runtime=nvidia --name="flash_occ_test113" \
    -v /home/pliuan/6dof-occ/FlashOCC:/FlashOCC \
    -v /data2:/dataset \
    nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04 \
    /bin/bash