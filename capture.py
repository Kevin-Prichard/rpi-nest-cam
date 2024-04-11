#!/usr/bin/env python3

'''capture.py'''
import cv, sys

import pudb; pu.db
cap = cv.CaptureFromCAM(0)  # /dev/video0

while True:
    if not cv.GrabFrame(cap):
        break
    frame = cv.RetrieveFrame(cap)
    print(json.dumps(sorted(dir(frame))))
    sys.stdout.write(frame.tostring())
    break
