searchkb() { # Поиск пакета обновления для Windosw по номеру наименованию KB.
    query=$1
    brave-browser "https://www.catalog.update.microsoft.com/search.aspx?q=$query"
}

