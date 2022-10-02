burn() { # Записать указанную директорию на /dev/sr0
    # TODO add checks for filepath
    # if filepath is .iso file:
    #    sudo wodim dev=/dev/sr0 -v -data $1
    # elif file is a directory:
    if [ "$EUID" -ne 0 ]; then 
        echo "Please run as root"
	else
        genisoimage -o /tmp/dvd.iso -R -J -allow-limited-size $1
        wodim dev=/dev/sr0 -v -data /tmp/dvd.iso
    fi
}
