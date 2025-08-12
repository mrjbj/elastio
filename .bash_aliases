alias docker-compose='docker compose'
alias rr='yazi'
alias ipinfo="ifconfig | awk '/^[a-z]/ { iface=\$1 } /inet / { print iface, \$2 }'"
alias ip4="ifconfig | awk '/^[a-z]/ { iface=\$1 } /inet / { print iface, \$2 }'"
alias ip6="ifconfig | awk '/^[a-z]/ { iface=\$1 } /inet6/ && !/fe80::1%lo0/ { print iface, \$2 }'"
alias digs='dig +short '
alias gkeys='ghostty +list-keybinds'
alias rr='yazi'

