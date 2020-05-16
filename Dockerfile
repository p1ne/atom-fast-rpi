FROM balenalib/raspberrypi3-python:3.7-build

WORKDIR /usr/src/app

RUN install_packages dbus libdbus-1-dev libdbus-glib-1-dev bluez bluez-tools bluetooth libbluetooth-dev libcairo2-dev libjpeg-dev libgif-dev libgirepository1.0-dev liblircclient-dev

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN git clone https://github.com/piface/pifacecommon.git && \
    git clone https://github.com/piface/pifacecad.git && \
    git clone https://github.com/tompreston/python-lirc.git && \
    cd pifacecommon/ && \
    python3.7 setup.py install && \
    cd ../pifacecad/ && \
    python3.7 setup.py install && \
    cd ../python-lirc/ && \
    make py3 && \
    python3.7 setup.py install

COPY ./atom-fast-zabbix.py .

CMD [ "python", "./atom-fast-zabbix.py" ]

