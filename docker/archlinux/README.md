# Containerized linux desktop streaming using sunshine & moonlight client

### for DevOps ~wink ~wink Archbtw

This setup is intended to be used with wsl2. I had lots of problems with virtualized(virtual-box) in corporate even on bombastic hardware its slow. WSL2 window passthrough is good but windows tiling sucks. I need linux/unix desktop experience/freedom and some corporates don't provide it to you.

This solution runs in docker inside wsl (tried on archlinux wsl, but probably works on ubuntu with some tweaks). And is surprisingly faster than virtual-box.

Because wsl2 is trash itself some stuff that includes graphics drivers might not work correctly, try NOT to install them eg: nvidia-open...

When using llvmpipe, compositors might break. Things like input won't initially work etc.
Thus don't use them.

I haven't tested wayland but probably won't work.

### Usage

Use `dependencies` file to specify your pacman/aur stuff

```
# is used for comments
some-pkg name
```

- run `build.sh` to build
- (optionally to automate) setup systemd service in wsl that runs `docker compose up` on directory
- customize `entrypoint.sh` however you like (but I suggest to to keep stuff that's already there)
- for moonlight try either `localhost` or ip of your wsl:

```powershell
wsl ip addr show eth0 | Select-String "inet " | ForEach-Object { $_.ToString().Trim().Split()[1].Split("/")[0] }
```

- don't forget to pick desired resolution in moonlight

### For Corporate Enjoyers

Your company might have some blocking setup. For this purpose you will probably need to export certificates from windows and import them into wsl. If your filestructure is similar to where arch stores them then they are handled by `build.sh` automatically.
This mainly touches AUR so if you don't need it then comment it out from `Dockerfile` and don't install those packages.

(TODO: include how to openssl them)

You might be prohibited or maybe even blocked to install stuff on your windows.
Either cry or try stuff like [scoop](https://scoop.sh/#/) and install moonlight from there.

### FAQ

###### Network issues

1. You might need to install ufw into your wsl and put these rules in it:

```
sudo ufw allow 47984:48010/tcp
sudo ufw allow 47998:48000/udp
sudo ufw allow 47999/udp
```

1. maybe windows firewall blocking something?

###### Desktop has borders around it

1. Moonlight settings -> Basic settings -> set resolution

###### Windows systemwide shortcuts conflicting with streamed desktop

1. Moonlight settings -> Input settings -> check "Capture system keyboard shortcuts in fullscreen"
2. (optional recommended) Moonlight settings -> Input settings -> check "Optimize mouse for remote desktop instead of games"

##### No audio

(TODO)

Feel free to edit however you want. BSD3 licensed:)
