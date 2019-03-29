#!/usr/bin/expec

spawn /usr/bin/vncserver -fg
expect "Password:"
send "$env(password)\r"
expect "Verify:"
send "$env(password)\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"
expect eof
wait
