#!/bin/bash

function main(){
    cd "$(dirname "$0")"
    if [ $# -lt 1 ];then
        echo "Usage: $0 [command] option";
        exit 1
    fi
    local -r CONTAINER=ros2_humble_nano
    docker ps|grep -q ${CONTAINER}
    if [ $? -eq 1 ]; then
        echo "${CONTAINER} is not running. Try to start."
        ./docker_start.sh
    fi
    docker exec -w ${HOME} -it ${CONTAINER} $@
}

main "$@"
