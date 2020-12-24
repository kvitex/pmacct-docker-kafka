FROM ubuntu:18.04

WORKDIR /opt/build

RUN apt update && apt install -y  build-essential wget libpcap-dev \
    librdkafka-dev libjansson-dev git libtool pkg-config  autoconf \
    automake cmake zlib1g-dev

RUN git clone -b release-1.9.2 https://github.com/apache/avro.git avro

WORKDIR /opt/build/avro/lang/c

RUN mkdir build

WORKDIR /opt/build/avro/lang/c/build

RUN cmake .. && make -j 4 && make install

WORKDIR /opt/build

RUN git clone -b 1.7.5 https://github.com/pmacct/pmacct.git pmacct

WORKDIR /opt/build/pmacct

RUN ./autogen.sh

RUN ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
     --enable-l2 --enable-debug  --enable-64bit  --enable-jansson \
      --enable-threads --enable-plabel --enable-kafka --enable-avro

RUN make
#If you have multiproccess build machine you can run build in multithreads.
#RUN make -j 4

RUN make install

ENV LD_LIBRARY_PATH=/usr/local/lib
 
CMD [ "/usr/sbin/sfacctd", "-f", "/etc/pmacct/sfacctd.conf", "-l", "6343" ]