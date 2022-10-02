burniso() { # Запись файла iso на /dev/sr0
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
	else
        wodim dev=/dev/sr0 -v -data $1
    fi
}
