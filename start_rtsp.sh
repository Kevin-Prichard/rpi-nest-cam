#!/usr/bin/env bash

rpicam-vid \
--autofocus-mode continuous \
--inline 1 \
--brightness 0.1 \
--contrast 1.0 \
--denoise cdn_off \
--sharpness 1.0 \
--level 4.1 \
--framerate 30 \
--width 640 \
--height 360 \
-t 0 \
-n \
--codec mjpeg \
-o - |

ffmpeg \
-fflags +genpts+nobuffer+igndts+discardcorrupt \
-flags low_delay \
-avioflags direct \
-hwaccel drm \
-hwaccel_output_format drm_prime \
-hide_banner \
-f alsa \
-thread_queue_size 8 \
-i plughw:0 \
-re \
-i - \
-c:v h264_v4l2m2m \
-b:v 1700k \
-fpsmax 30 \
-c:a libopus \
-b:a 32k \
-application lowdelay \
-ar 48000 \
-f s16le \
-threads 4 \
-f rtsp \
-rtsp_transport tcp \
rtsp://:8554/mystream


# --codec libav \
# --libav-format mpegts \
# --libav-video-codec h264_v4l2m2m \

