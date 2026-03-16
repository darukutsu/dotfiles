FROM archlinux:latest

ARG USERNAME
ARG SSHDIR
ARG CONFDIR

##INITIAL SETUP...
RUN pacman -Syu --noconfirm base base-devel git sudo ca-certificates go dbus

## THIS IS IMPORTANT CUZ SIEMENS SHIT CERTIFICATES BLOCKING
## FIRSTLY COPY STUFF FROM WINDONS (TODO)
## THEN MOVE YOUR CERTS to this directory
#COPY ssl/certs /etc/ssl/certs
COPY ssl /etc/ssl
COPY ca-certificates /etc/ca-certificates

RUN update-ca-trust

RUN tee /etc/pacman.conf <<EOF
[options]
HoldPkg     = pacman glibc
Architecture = auto
Color
VerbosePkgLists
ParallelDownloads = 5
#DownloadUser = alpm
NoExtract = usr/lib/modules/*
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

[lizardbyte]
SigLevel = Optional
Server = https://github.com/LizardByte/pacman-repo/releases/latest/download
EOF

RUN sed -i '/^OPTIONS/ s/debug/!debug/' /etc/makepkg.conf

## NO OPENGL
RUN mkdir -p /etc/X11/xorg.conf.d
RUN tee /etc/X11/xorg.conf.d/10-dummy.conf <<EOF
Section "ServerFlags"
    Option "AutoAddDevices" "true"
    Option "AutoEnableDevices" "true"
    #Option "AllowEmptyInput" "true"
EndSection
Section "Device"
    Identifier "DummyDevice"
    Driver "dummy"
    # decrease this if needed
    VideoRam 512000
EndSection
Section "Monitor"
    Identifier "DummyMonitor"
    HorizSync 28-80
    VertRefresh 48-75
    # or specify custom resolution that your monitor has
    Modeline "1920x1080" 148.50 1920 2008 2052 2200 1080 1084 1089 1125 +hsync +vsync
    Modeline "2560x1440" 312.25 2560 2752 3024 3488 1440 1443 1448 1493 -hsync +vsync
    Modeline "3840x2160" 712.75 3840 4160 4576 5312 2160 2163 2168 2237 -hsync +vsync
EndSection
Section "Screen"
    Identifier "DummyScreen"
    Device "DummyDevice"
    Monitor "DummyMonitor"
    DefaultDepth 24
    SubSection "Display"
        Depth 24
        Modes "1920x1080" "2560x1440" "3840x2160"
        Virtual 3840 2160
    EndSubSection
EndSection
EOF

RUN mkdir -p /etc/X11/xorg.conf.d
RUN tee /etc/X11/xorg.conf.d/10-screen.conf <<EOF
Section "Device"
    Identifier "GPU"
    Driver "modesetting"
EndSection
Section "Monitor"
    Identifier "Monitor"
    HorizSync 28-80
    VertRefresh 48-75
EndSection
Section "Screen"
    Identifier "Screen"
    Device "GPU"
    Monitor "Monitor"
    DefaultDepth 24
    SubSection "Display"
        Depth 24
        Modes "1920x1080"
        Virtual 1920 1080
    EndSubSection
EndSection
EOF

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
