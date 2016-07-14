FROM alpine:3.4
MAINTAINER Riccardo Ferrazzo

WORKDIR /root
EXPOSE 55535

ADD https://github.com/nomovok-opensource/cutedriver-driver/archive/master.tar.gz driver.tar.gz
ADD https://github.com/nomovok-opensource/cutedriver-sut_qt/archive/master.tar.gz sut-qt.tar.gz

RUN \
apk --update add --no-cache ruby ruby-libs ruby-json ruby-dev libxml2 libstdc++ libgcc gmp zlib; \
apk add --virtual build_deps ruby-bundler g++ ruby-doc ruby-rake gcc zlib-dev gmp-dev patch make; \
gem install nokogiri; \
tar -xzf driver.tar.gz; \
cd cutedriver-driver-master; \
rake gem; \
gem install pkg/cutedriver-driver*.gem; \
cd ..; \
rm -f driver.tar.gz; \
rm -rf cutedriver-driver-master; \
tar -xzvf sut-qt.tar.gz; \
cd cutedriver-sut_qt-master; \
rake gem; \
gem install pkg/cutedriver-qt-sut-plugin*.gem; \
cd ..; \
rm -f sut-qt.tar.gz; \
rm -rf cutedriver-sut_qt-master; \
apk del build_deps;

ENTRYPOINT ["ruby"]
