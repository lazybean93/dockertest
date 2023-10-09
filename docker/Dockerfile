FROM debian

RUN apt-get update && apt-get install -y \
    bc \
    cron \
    expect \
    firefox-esr \
    git \
    locales \
    iputils-ping \
    nano \
    nmap \
    htop \
    openbox \
    openssh-server \
    procps \
    python3-pip \
    tightvncserver \
    wget \
    wmctrl \
    xxd \
    && rm -rf /var/lib/apt/lists/*

#set locales
ENV LANG=de_DE.UTF-8
RUN sed -i -e "s/# $LANG.*/$LANG UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG

#set Users
RUN useradd -rm -d /home/automate -s /bin/bash -g root -u 1000 automate \
    && echo 'root:automate' | chpasswd \
    && echo 'automate:automate' | chpasswd

#setup ssh
RUN service ssh start
EXPOSE 22

#setup vnc server
EXPOSE 5901

#setup selenium
RUN pip install --break-system-packages selenium \
    && wget https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz \
    && tar -xf geckodriver-v0.33.0-linux64.tar.gz \
    && mv geckodriver /usr/bin

#setup taskspooler
RUN wget https://viric.name/soft/ts/ts-1.0.2.tar.gz \
    && tar -xf ts-1.0.2.tar.gz \
    && cd ts-1.0.2 \
    && cat Makefile | sed 's/ts/tsp/g;s/tsp.1 /ts.1 /g' > M \
    && mv M Makefile \
    && make install \
    && cd / \
    && rm *.tar.gz \
    && rm -r ts-1.0.2

#clone git repo
RUN git clone https://github.com/lazybean93/automate.git \
    && mv /home/automate/ /home/automate1 \
    && mv /automate /home/automate \
    && mv /home/automate1/.b* /home/automate/ \
    && mv /home/automate1/.p* /home/automate/ \
    && rm -rf /home/automate1/ \
    && chown -R automate:root /home/automate

#copy files to image
COPY userfiles /home/automate
RUN chown -R automate:root /home/automate\
    && chmod 0600 /home/automate/.vnc/passwd
ADD /start.sh /

#cronjobs
RUN FILE=/home/automate/crontab_automate \
    && crontab -u automate $FILE \
    && rm $FILE
RUN echo "@reboot /usr/sbin/sshd" > FILE \
    && crontab FILE \
    && rm FILE

USER root
CMD [ "sh", "/start.sh" ]