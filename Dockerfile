FROM ubuntu:trusty
MAINTAINER info@zenosmosis.com

RUN sudo apt-get update
RUN sudo apt-get -y install \
    ruby \
    ruby-dev \
    fontforge \
    ttfautohint \
    unzip \
    libz-dev \
    software-properties-common \
    python-software-properties \
    wget

# get latest build
# @see https://github.com/instructure/canvas-lms/issues/1073
RUN apt-get install make
WORKDIR woff
RUN wget http://pkgs.fedoraproject.org/repo/pkgs/woff/woff-code-latest.zip/1dcdbc9a7f48086185740c185d822279/woff-code-latest.zip
# RUN wget http://people.mozilla.com/~jkew/woff/woff-code-latest.zip
RUN unzip woff-code-latest.zip
RUN ls
# RUN cd woff
RUN make
RUN sudo mv sfnt2woff /usr/local/bin/
RUN cd ..
RUN rm -Rf woff woff-code-latest.zip

# finally fontcustom (can we lock down specific ver?)
RUN echo "Install ruby gem fontcustom v1.3.8 (may take awhile)..."
RUN sudo gem install fontcustom -v 1.3.8

# finish off with java 8
RUN sudo add-apt-repository -y ppa:webupd8team/java
RUN sudo apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN sudo apt-get install -y oracle-java8-installer
RUN sudo update-java-alternatives -s java-8-oracle

# EXPOSE 8080
WORKDIR /app
COPY ./ /app
RUN java -jar blaze.jar
