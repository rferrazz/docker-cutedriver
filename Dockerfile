FROM debian:latest
MAINTAINER Riccardo Ferrazzo

WORKDIR /root
EXPOSE 55535

RUN \
apt-get update; \
apt-get install -y ruby rake ruby-all-dev gcc zlib1g-dev libxml2 patch make; \
rm -rf /var/lib/apt/lists/*;

## Build cutedriver-driver
ADD https://github.com/nomovok-opensource/cutedriver-driver/archive/master.tar.gz driver.tar.gz

RUN \
tar -xzf driver.tar.gz; \
cd cutedriver-driver-master; \
rake gem; \
gem install pkg/cutedriver-driver*.gem; \
cd ..; \
rm -f driver.tar.gz; \
rm -rf cutedriver-driver-master;

## Build cutedriver-sut_qt
ADD https://github.com/nomovok-opensource/cutedriver-sut_qt/archive/master.tar.gz sut-qt.tar.gz

RUN \
tar -xzvf sut-qt.tar.gz; \
cd cutedriver-sut_qt-master; \
rake gem; \
gem install pkg/cutedriver-qt-sut-plugin*.gem; \
cd ..; \
rm -f sut-qt.tar.gz; \
rm -rf cutedriver-sut_qt-master;

ENTRYPOINT ["ruby"]