massProv.sh
====================
Provision mass lxc containers. Need to have chef server configured or use cloud Chef.

Typical scenario
```y=0; for x in $(cat users.list); do ./massProv.sh $x $((220+$y)); y=$((y+1)); done``
