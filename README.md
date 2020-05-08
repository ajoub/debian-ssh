debian-ssh
==========

Simple Debian/Ubuntu Docker images with *passwordless* SSH access and a regular user
with `sudo` rights and VNC

# Building

```
docker build --tag debian:1.0 .
```

# Using

To run for the first time:

```
git clone git@github.com:ajoub/debian-ssh.git
cd debian-ssh
docker run -d -p 2222:22 p 5901:5901 -e SSH_KEY="$(cat ~/.ssh/id_rsa.pub)" debian:1.0
```

This requires a public key in `~/.ssh/id_rsa.pub`.

Two users exist in the container: `root` (superuser) and `docker` (a regular user
with passwordless `sudo`). SSH access using your key will be allowed for both
`root` and `docker` users.

To connect to this container as root:

```
ssh -p 2222 root@localhost
```

To allow the regular user to ssh, set their password by running as root:

```
passwd docker
```

Then the regular user may ssh into this container with:

```
ssh -p 2222 docker@localhost
```

Change `2222` to any local port number of your choice.

## VNC
### In container
As regular user docker, run:

```
sudo apt install tightvncserver
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
