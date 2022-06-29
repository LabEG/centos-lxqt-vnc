#!/usr/bin/expec

# set screen resolution from environment variable 'resolution' or default 1820x960
set SCREEN_RESOLUTION 1920x1080
catch {set SCREEN_RESOLUTION $env(resolution)}

set PASSWORD $env(password)

set USER_PASSWORD $PASSWORD
catch {set USER_PASSWORD $env(user_password)}

set ROOT_PASSWORD $USER_PASSWORD
catch {set ROOT_PASSWORD $env(root_password)}

set HOME $env(HOME)

# unsets by security reason, user can write env in demonstration time
system "unset password"
system "unset user_password"
system "unset root_password"

system "rm -fr /tmp/.X11-unix/*; rm -fr /tmp/.X1-lock; rm -fr /home/headless/.Xauthority; rm -fr /home/headless/.vnc/*.log; rm -fr /home/headless/.vnc/*.pid"

if { ! [file exists $HOME/.issetpassword] } {
    # change root user password
    spawn sudo passwd root
    expect "\\\[sudo\\\] password for headless:"
    send "centos\r"
    expect "New password:"
    send "$ROOT_PASSWORD\r"
    expect "Retype new password:"
    send "$ROOT_PASSWORD\r"
    expect eof

    # change headless user password
    spawn passwd
    expect "Current password:"
    send "centos\r"
    expect "New password:"
    send "$USER_PASSWORD\r"
    expect "Retype new password:"
    send "$USER_PASSWORD\r"
    expect eof

    system "echo 'true' > $HOME/.issetpassword"

    # launch vnc
    spawn /usr/bin/vncserver :1 -fg -geometry $SCREEN_RESOLUTION
    expect "Password:"
    send "$PASSWORD\r"
    expect "Verify:"
    send "$PASSWORD\r"
    expect "Would you like to enter a view-only password (y/n)?"
    send "n\r"
} else {
    spawn /usr/bin/vncserver :1 -fg -geometry $SCREEN_RESOLUTION
}

set timeout -1
expect eof
