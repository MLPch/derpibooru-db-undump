#!/bin/bash

dump_file="$(find "$(dirname "${BASH_SOURCE[0]}")/" -iname *.pgdump)"
docker_img="derpibooru-pg-dump-img"
docker_cont="derpibooru-pg-dump"


if [ ! -e "$dump_file" ]; then
    echo "Enter the address of the pgdump file, you can get it at the page"
    echo -e "\thttps://www.derpibooru.org/pages/data_dumps"
    echo -e "\tExample: https://files.derpicdn.net/derpibooru_public_dump_XXXX_XX_XX.pgdump"
    
	read url_dump
	wget --continue --tries=0 $url_dump -P "$(dirname "${BASH_SOURCE[0]}")/dump"
fi

docker build -t "$docker_img" "$(dirname "${BASH_SOURCE[0]}")/"

docker run -d \
		   -e POSTGRES_USER=postgres \
		   -e POSTGRES_PASSWORD=postgres \
		   -p 5532:5432 \
		   --name "$docker_cont" \
		   "$docker_img" 2>&1 > /dev/null

docker exec -it "$docker_cont" bash "/dump/external-access.sh"

docker restart --time 5 "$docker_cont" 2>&1 > /dev/null
sleep 10

docker exec -it "$docker_cont" bash "/dump/restore.sh"