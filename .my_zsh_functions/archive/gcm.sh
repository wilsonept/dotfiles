gcm() { # Getting list of custom .bashrc functions
    cat ~/.bashrc | grep -Ev "^\s" | grep -E '^\w+\s?\()' | awk '{s="";for(i=4;i<=NF;i++)s=s $i " ";print $1" "s}' | nl -w2 -s'. '
}
