#!/usr/bin/liquidsoap
###########################################################
#
#
#
#
#
###########################################################

###########################################################
# Log file configuration
###########################################################
set("log.file.path","/var/log/liquidsoap/radio.log")
set("log.file.perms",775)
set("log.unix_timestamps",true)

###########################################################
# Audio Sources Configuration
###########################################################
#==================== URL Audio Stream ===================#
# URL="http://ubuntu.hbrl.com:19800/trance.ogg"
# SOURCE=mksafe(input.http(URL))
#==================== Alsa Audio Input ===================#
SOURCE = input.alsa(bufferize=true,fallible=false,device="hw:1,0")

###########################################################
# Icecast Host
###########################################################
HOST="icecast_host_name_here" # Icecast host addres 

###########################################################
# Audio Stream Configuration
###########################################################
# OGG Stream
output.icecast(%ogg(%flac(
                        samplerate=44100,
                        channels=2,
                        compression=0,
                        bits_per_sample=16
                )),
        mount="test.ogg",
        name="TESTE_OGG",
        description="Audio stream test",
        password="icecast_client_password_here",
        host=HOST,
        port=8000,
        url="http://$HOST:8000",
        genre='Misc',
        source
		)

############################################################
# MP3 (arbitrary bit-rate)
output.icecast(%mp3.abr(
                         stereo=true,
                         bitrate=128,
                         max_bitrate=192
                        ),
        mount="test.mp3",
        name="TEST_MP3",
        genre="Misc",
        description="Adio stream test",
        password="icecast_client_password_here",
        host=HOST,
        port=8000,
        url="http://$HOST:8000",
        source
)

############################################################
# OPUS Stream
output.icecast(%opus(
		vbr="constrained",
		application="audio",
		complexity=10,
		max_bandwidth="full_band",
		samplerate=48000,
		bitrate=500,
		channels=2,
		signal="music"
		),
	mount="test.opus",
	name="TEST_OPUS",
	genre="Misc",
	descriptio="Audio Stream test",
	password="icecast_client_password_here",
	host=HOST,
	port=8000,
	url="http://$HOST:8000",
	SOURCE
)

############################################################
# End of file
############################################################






















