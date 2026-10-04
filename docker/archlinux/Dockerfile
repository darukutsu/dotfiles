FROM archlinux:latest

ARG USERNAME

## Host pacman config (repos + mirrorlist) copied in BEFORE the first sync so
## the image builds against the same repos/mirrors (e.g. LizardByte/Sunshine).
COPY etc/pacman.conf /etc/pacman.conf
COPY etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist

## WSL/Docker: Landlock isn't available in the build sandbox, so pacman's
## sandbox (DownloadUser=alpm + Landlock) fails. Disable it for the build.
RUN sed -i -e 's/^DownloadUser/#DownloadUser/' \
	-e 's/^#\?DisableSandbox$/DisableSandbox/' \
	-e 's/^#\?DisableSandboxFilesystem$/DisableSandboxFilesystem/' /etc/pacman.conf

##INITIAL SETUP...
RUN pacman -Syu --noconfirm base base-devel git sudo ca-certificates go dbus

## THIS IS IMPORTANT CUZ CORPORATE SHIT CERTIFICATES BLOCKING
## Only the corporate trust anchors are copied in (seeded from the host by
## build.sh into ./etc/ca-certificates/trust-source/anchors). update-ca-trust
## then MERGES them with the distro certs instead of clobbering /etc/ssl.
COPY etc/ca-certificates/trust-source/anchors /etc/ca-certificates/trust-source/anchors

RUN update-ca-trust

## Host X11 config (xorg.conf.d, xinit) so Xorg starts with the same setup.
COPY etc/X11 /etc/X11

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
## make this use pacman not everyone wants needs aur
RUN sed '/^#/d' /home/${USERNAME}/dependencies | xargs yay -Syu --noconfirm

ENTRYPOINT ["/entrypoint.sh"]
