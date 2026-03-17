#!/bin/bash
export SHELL=/bin/bash # why don't wsl do this ootb

if ! [ -e ~/.bashrc ]; then
  ln -s /home/${USERNAME}/.config/bash/.bashrc /home/${USERNAME}/.bashrc
fi

# maybe should be moved to compose
export KITTY_DISABLE_WAYLAND=1
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_STATE_HOME=${HOME}/.local/state
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DOWNLOAD_DIR=${HOME}/Downloads
mkdir -p $XDG_DOWNLOAD_DIR
export XDG_RUNTIME_DIR=/run/user/$(id -u)
sudo mkdir -p ${XDG_RUNTIME_DIR}
sudo chown ${USERNAME}:${USERNAME} ${XDG_RUNTIME_DIR}
sudo chmod 700 ${XDG_RUNTIME_DIR}

if [ -e /tmp/.X1-lock ]; then
  sudo rm /tmp/.X1-lock
fi
sudo mkdir -p /tmp/.X11-unix
sudo chmod 1777 /tmp/.X11-unix

sudo dbus-uuidgen | sudo tee /etc/machine-id >/dev/null
sudo rm -f /run/dbus/pid
sudo mkdir -p /run/dbus
sudo dbus-daemon --system --fork
export DBUS_SESSION_BUS_ADDRESS=$(dbus-launch --sh-syntax | grep DBUS_SESSION_BUS_ADDRESS | cut -d= -f2-)

sudo chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.config/pulse

# some apps need bigger opengl I was not able to overcome wsl fucking limitation
# this can mangle with compositors such as picom and maybe even kwin
# use glx then
#
# you don't need to do this move if you don't install nvidia-open but in case you did uncomment
#sudo mv /usr/lib/libEGL_nvidia.so* /usr/lib/libnvidia-egl-*.so* /home/${USERNAME}/ 2>/dev/null || true
#sudo ldconfig
sudo chmod 660 /dev/uinput
sudo LD_PRELOAD="" LD_LIBRARY_PATH="" Xorg ${DISPLAY} -noreset &

# alternative way of doing if opengl not needed
#sudo LD_PRELOAD="" LD_LIBRARY_PATH="" Xorg ${DISPLAY} -noreset -extension GLX &

# other xorg alternative
#EGL_PLATFORM=surfaceless \
#  LIBGL_ALWAYS_SOFTWARE=1 \
#  GALLIUM_DRIVER=softpipe \
#  __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json \
#  LD_PRELOAD="" \
#  LD_LIBRARY_PATH="" \
#  Xvfb ${DISPLAY} -screen 0 1920x1080x24 &
sleep 1

sunshine &
SUNSHINE_PID=$!

# YOUR DESKTOP CONFIG
bspwm &
#sxhkd &

# if you remove this container will stop
wait $SUNSHINE_PID
