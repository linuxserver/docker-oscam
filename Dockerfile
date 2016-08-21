FROM lsiobase/alpine
MAINTAINER saarg

# add runtime dependencies required for Oscam
RUN \	
 apk add --no-cache \
	libcrypto1.0 \
	libssl1.0 \
	libusb \
#	openssl \
	pcsc-lite \
	pcsc-lite-libs && \
#	usbutils && \

# add build time dependencies 
 apk add --no-cache --virtual=build-dependencies \
	curl \
	gcc \
	g++ \
	libusb-dev \
	linux-headers \
	make \
	openssl-dev \
	pcsc-lite-dev \
	subversion \
	tar && \

# compile oscam from source
 svn checkout http://www.streamboard.tv/svn/oscam/trunk /tmp/oscam-svn && \
 cd /tmp/oscam-svn && \
 ./config.sh \
	--enable all --disable \
		CARDREADER_DB2COM \
		CARDREADER_INTERNAL \
		CARDREADER_STINGER \
		CARDREADER_STAPI \
		CARDREADER_STAPI5 \
		IPV6SUPPORT \
		LCDSUPPORT \
		LEDSUPPORT \
		READ_SDT_CHARSETS && \
 make \
	OSCAM_BIN=/usr/bin/oscam \
	NO_PLUS_TARGET=1 \
	CONF_DIR=/config \
	DEFAULT_PCSC_FLAGS="-I/usr/include/PCSC" \
	pcsc-libusb && \	
	
# fix broken permissions from pcscd install.
 chown root:root \
 	/usr/sbin/pcscd && \
 chmod 755 \
 	/usr/sbin/pcscd && \

# install PCSC drivers for OmniKey devices
 mkdir -p \
 /tmp/omnikey && \
 curl -o \
 /tmp/omnikey.tar.gz -L \
 	https://www.hidglobal.com/sites/default/files/drivers/ifdokccid_linux_x86_64-v4.2.8.tar.gz && \
 tar xzf /tmp/omnikey.tar.gz -C \
 	/tmp/omnikey --strip-components=2 && \
 cd /tmp/omnikey && \
 ./install && \

# fix group for card readers and add abc to dialout group
 groupmod -g 24 cron && \
 groupmod -g 16 dialout && \
 usermod -a -G 16 abc && \

# cleanup
 apk del --purge \
	build-dependencies && \
	
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# Ports and volumes
EXPOSE 8888
