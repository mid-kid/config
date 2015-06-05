brightness() {
    sudo su -c "echo $1 > /sys/class/backlight/intel_backlight/brightness"
}
