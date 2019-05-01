#!/usr/bin/expec

spawn /usr/bin/vncserver -fg -geometry 1920x1080 :1
expect "Password:"
send "$env(password)\r"
expect "Verify:"
send "$env(password)\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"

set timeout -1
expect eof
