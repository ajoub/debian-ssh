debian-ssh
==========

Simple Debian/Ubuntu Docker image with VNC and with a non-root user with SSH
access and `sudo` rights.

# Using

To run for the first time:

```
git clone git@github.com:ajoub/debian-ssh.git
cd debian-ssh
docker build --tag debian:1.0 .
docker run -d -p 2222:22 -p 5901:5901 -e SSH_KEY="$(cat ~/.ssh/id_rsa.pub)" --name debian debian:1.0
```

Change `2222` to any local port number of your choice.

This requires a public key in `~/.ssh/id_rsa.pub`.

Two users exist in the container: `root` (superuser) and `docker` (a regular user
with `sudo`). SSH access using your key will be allowed for the `docker` user
only.

To ssh into the container:

```
ssh -p 2222 docker@localhost
```

To stop the container:

```
docker stop debian
```

To start the container:

```
docker start debian
```

To destroy the container:

```
docker rm --force debian
```

## VNC
### In container
As regular user docker, run:

```
vncserver
```

Enter password with 6 <= length <= 8

```
Would you like to enter a view-only password (y/n)? n
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
vim ~/.vnc/xstartup
```

Press I (capital i) for insert mode. Paste the following (try Ctrl + Shift +
V):

```
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
```

Press Esc and then :wq to write changes (w) and quit (q).

```
sudo chmod +x ~/.vnc/xstartup
vncserver
```

### On host

```
sudo apt install xtightvncviewer
xtightvncviewer
```

Click on white box that appears in the middle of the screen to give it focus.
Enter `localhost:5901` and press Enter.
Enter the password and press Enter.
You should now see the desktop of the container.
