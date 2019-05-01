#!/usr/bin/expec

spawn /usr/bin/vncserver :1 -fg -geometry 1820x960
expect "Password:"
send "$env(password)\r"
expect "Verify:"
send "$env(password)\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"

set timeout -1
expect eof
