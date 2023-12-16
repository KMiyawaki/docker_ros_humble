#!/bin/bash

function main(){
    cd "$(dirname "$0")"
    local -r CONTAINER=ros2_humble_nano
    docker ps|grep -q ${CONTAINER}
    if [ $? -eq 1 ]; then
        echo "${CONTAINER} is not running. Try to start."
        ./docker_start.sh
    fi
    docker exec -w ${HOME} -it ${CONTAINER} /bin/bash
}

main "$@"
