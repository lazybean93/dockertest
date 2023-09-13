FROM debian

#general packages
RUN apt-get update && apt-get install -y nano htop locales cron procps
RUN service cron start

#set locales
ENV LANG=de_DE.UTF-8
RUN sed -i -e "s/# $LANG.*/$LANG UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG

#set Users
RUN useradd -rm -d /home/automate -s /bin/bash -g root -u 1000 automate
RUN echo 'root:automate' | chpasswd
RUN echo 'automate:automate' | chpasswd
RUN echo "alias tsp=ts" >> /home/automate/.bashrc 

#setup ssh
RUN apt-get install -y openssh-server
RUN service ssh start
EXPOSE 22

#setup wm
RUN apt-get install -y openbox firefox-esr

#setup vnc server
RUN apt-get install -y tightvncserver
EXPOSE 5901

#setup selenium
RUN apt-get install -y python3-pip
RUN pip install --break-system-packages selenium
RUN apt-get install -y wget
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz
RUN tar -xf geckodriver-v0.33.0-linux64.tar.gz
RUN mv geckodriver /usr/bin

#setup taskspooler
RUN wget https://viric.name/soft/ts/ts-1.0.2.tar.gz
RUN tar -xf ts-1.0.2.tar.gz
RUN cd ts-1.0.2 && make install
RUN rm *.tar.gz && rm -r ts-1.0.2

#clone git repo
RUN apt-get install -y git
#USER automate
RUN git clone https://github.com/lazybean93/automate.git && cp -r automate/* /home/automate/
RUN chown -R automate:root /home/automate

#copy files to image
ADD --chown=automate:root userfiles /home/automate
ADD start.sh crontab_root /

RUN FILE=/home/automate/crontab_automate && crontab -u automate $FILE && rm $FILE
RUN FILE=/crontab_root && crontab $FILE && rm $FILE

USER root
CMD [ "sh", "/start.sh" ]

#RUN apt-get install -y expect
#RUN apt-get install -y xorg
#RUN apt-get install -y tint2
#RUN apt-get install -y openbox

#RUN apt-get install -y firefox-esr
#RUN useradd automate

#RUN echo "spawn passwd automate" > expect_passwd.sh
#RUN echo 'expect "word:"' >> expect_passwd.sh
#RUN echo 'send "123\r"' >> expect_passwd.sh
#RUN echo 'expect "word:"' >> expect_passwd.sh
#RUN echo 'send "123\r"' >> expect_passwd.sh
#RUN echo 'expect eol' >> expect_passwd.sh
#RUN expect expect_passwd.sh

#RUN echo 'spawn /etc/init.d/ssh start' > expect_ssh.sh
#RUN echo 'expect eol' >> expect_ssh.sh
#RUN expect expect_passwd.sh
#RUN chmod +x expect.sh

#CMD [ "expect", "expect.sh", "&" ]
#USER automate
#WORKDIR /home/automate
#ENV USER=automate
#COPY userfiles .