FROM archlinux:latest

ARG USERNAME

##INITIAL SETUP...
RUN pacman -Syu --noconfirm base base-devel git sudo ca-certificates go dbus

## THIS IS IMPORTANT CUZ CORPORATE SHIT CERTIFICATES BLOCKING
## FIRSTLY COPY STUFF FROM WINDONS (TODO)
## THEN MOVE YOUR CERTS to this directory
COPY etc /etc

RUN update-ca-trust

RUN sed -i '/^OPTIONS/ s/debug/!debug/' /etc/makepkg.conf

## STARTUP SCRIPT
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

# this is useless
## SYSTEMD SESSION
#RUN systemctl enable --now dbus
#RUN tee /etc/systemd/system/desktop.service <<EOF
#[Unit]
#Description=Desktop Session
#After=dbus.service
#
#[Service]
#Type=simple
#User=${USERNAME}
#Environment=DISPLAY=:0
#Environment=GALLIUM_DRIVER=d3d12
#Environment=LD_LIBRARY_PATH=/usr/lib/wsl/lib
#ExecStart=/entrypoint.sh
#
#[Install]
#WantedBy=multi-user.target
#EOF
#RUN systemctl enable desktop.service

## USER CREATION...
## yay don't forget to change this to some password later
RUN useradd -m -G wheel,audio,input,storage,tty,uucp,video ${USERNAME} && \
	echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}

## OPTIONAL DEPENDENCIES INSTALLATION + AUR
RUN git clone https://aur.archlinux.org/yay.git /tmp/yay && \
	cd /tmp/yay && makepkg -si --noconfirm

COPY dependencies /home/${USERNAME}/dependencies
RUN sudo chmod 755 /home/${USERNAME}/dependencies
RUN sed '/^#/d' /home/${USERNAME}/dependencies | xargs yay -Syu --noconfirm

ENTRYPOINT ["/entrypoint.sh"]
