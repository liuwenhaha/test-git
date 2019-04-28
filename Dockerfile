FROM ubuntu:16.04
EXPOSE 80
ADD ./ /service
RUN cp /service/sources.list /etc/apt/ 

## Install Python -version 3.5, pip -version 19.1
RUN apt-get update && \
    apt-get install -y python3-dev python3-pip && \
    apt-get install -y mycli vim wget zip unzip && \
    pip3 install --trusted-host pypi.doubanio.com -i http://pypi.doubanio.com/simple/ --upgrade pip setuptools wheel numpy requests tornado protobuf flask gevent imageio pytz opencv-python arrow mysql-connector-python==8.0.12 

## Install Opencv 3.4.4
RUN apt-get install -y build-essential cmake git && \
    apt-get install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev python-numpy cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev

RUN cd /opt && \
    wget https://github.com/opencv/opencv/archive/3.4.4.zip && \
    unzip 3.4.4.zip && \
    rm 3.4.4.zip && \
    cd opencv-3.4.4 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j8 && \
    make install && \
    cp /opt/opencv-3.4.4/build/lib/python3/cv2.cpython-35m-x86_64-linux-gnu.so /usr/local/lib/python3.5/dist-packages

##Install keras -version 2.2 , tensorflow -version 1.8
RUN pip3 install keras==2.2.4 && \
    pip3 install tensorflow==1.8 -i https://pypi.tuna.tsinghua.edu.cn/simple  


ADD ./ /service
ADD ./vimrc /root/.vimrc
WORKDIR /service