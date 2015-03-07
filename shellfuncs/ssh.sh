ssh() {
    config=($(~/.shellfuncs/sshload.py "$1"))
    if [ "$config" ]; then
        env ssh ${config[@]}
    else
        env ssh $@
    fi
}
