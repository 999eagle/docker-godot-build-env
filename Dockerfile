FROM ubuntu:18.04

RUN apt-get update && \
	apt-get -y upgrade

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get -y install ca-certificates gnupg2
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
	echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
	apt-get update && \
	apt-get -y install mono-complete

RUN apt-get -y install build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev \
	libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libfreetype6-dev libssl-dev libudev-dev \
	libxi-dev libxrandr-dev mingw-w64 msbuild wget

ARG GODOT_VERSION=3.0.6

RUN mkdir -p /build/godot-src && \
	cd /build/godot-src && \
	wget "https://github.com/godotengine/godot/archive/${GODOT_VERSION}-stable.tar.gz" -O "src.tar.gz" && \
	tar -xzf src.tar.gz && \
	rm src.tar.gz && \
	mv godot-${GODOT_VERSION}-stable src
