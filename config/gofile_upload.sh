# ================= GOFILE =================
gofile_upload() {
    local FILE="$1"

    mapfile -t SERVERS < <(curl -s https://api.gofile.io/servers | jq -r '.data.servers[].name')

    for S in $(printf "%s\n" "${SERVERS[@]}" | shuf); do
        RESP=$(curl -s -F "file=@${FILE}" "https://${S}.gofile.io/uploadFile")
        LINK=$(echo "$RESP" | jq -r '.data.downloadPage // empty')

        if [ -n "$LINK" ]; then
            echo "$LINK"
            return
        fi
    done

    return 1
}