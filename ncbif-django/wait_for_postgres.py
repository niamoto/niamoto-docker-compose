# coding: utf-8

import socket
import time

port = 5432

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
while True:
    try:
        s.connect(('ncbif-postgres', port))
        s.close()
        break
    except socket.error as ex:
        time.sleep(0.1)
