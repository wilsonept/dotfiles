getupdate() { # Скачать обновления определенной версии касперского. Принимает номер версии в качестве параметра.
    case $1 in
    10)
	    echo "lin-10-install.sh activated"
	    sudo /opt/kuu/Scripts/lin-10-install.sh
    ;;
    11)
	    echo "lin-11-install.sh activated"
            sudo /opt/kuu/Scripts/lin-11-install.sh
    ;;
    *)
	    echo "Укажите номер версии 10 или 11 в качестве параметров и повторите попытку"
    esac
}
