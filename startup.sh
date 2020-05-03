#!/usr/bin/expec

# set screen resolution from environment variable 'resolution' or default 1820x960
set SCREEN_RESOLUTION 1920x1080
catch {set SCREEN_RESOLUTION $env(resolution)}

system "rm -fr /tmp/.X11-unix/*; rm -fr /tmp/X1-lock; rm -fr /home/headless/.Xauthority; rm -fr /home/headless/.vnc/*.log; rm -fr /home/headless/.vnc/*.pid"

spawn /usr/bin/vncserver :1 -fg -geometry $SCREEN_RESOLUTION
expect "Password:"
send "$env(password)\r"
expect "Verify:"
send "$env(password)\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"

set timeout -1
expect eof
