#!/bin/bash -e

# Who and where am I ?
echo >&2 "[INFO] ---------------------------------------------------------------"
echo >&2 "[INFO] GLOBAL INFORMATIONS"
echo >&2 "[INFO] ---------------------------------------------------------------"
echo >&2 "[INFO] whoami : $(whoami)"
echo >&2 "[INFO] pwd : $(pwd)"


# Check env
echo >&2 "[INFO] ---------------------------------------------------------------"
echo >&2 "[INFO] Checking configuration"
echo >&2 "[INFO] ---------------------------------------------------------------"
error=0
if [ -z "$GATEWAY_HOST" ]; then 
    echo >&2 "Missing GATEWAY_HOST env var to set the remote gateway you want to go trought" 
    error=1
fi
if [ -z "$GATEWAY_USER" ]; then 
    echo >&2 "Missing GATEWAY_USER  to set gateway credentials" 
    error=1
fi
if [ -z "$GATEWAY_PWD" ]; then 
    echo >&2 "Missing GATEWAY_PWD to set gateway credentials" 
    error=1
fi
if [ -z "$TUNNEL_LOCAL_PORT" ]; then 
    echo >&2 "Missing TUNNEL_LOCAL_PORT" 
    error=1
fi
if [ -z "$TUNNEL_REMOTE_HOST" ]; then 
    echo >&2 "Missing TUNNEL_REMOTE_HOST" 
    error=1
fi
if [ -z "$TUNNEL_REMOTE_PORT" ]; then 
    echo >&2 "Missing TUNNEL_REMOTE_PORT" 
    error=1
fi

# If error print usage and exit
if [ $error -eg 1 ]; then
    echo >&2 "[INFO] Please check your configuration (and see below example)"
cat << EOF

Usage :
    docker run -d \
        --net=host \
        -e GATEWAY_HOST="my.gateway.host" \
        -e GATEWAY_USER="user" \
        -e GATEWAY_PWD="password" \
        -e TUNNEL_LOCAL_PORT="local_port" \
        -e TUNNEL_REMOTE_HOST="my.remote.host" \
        -e TUNNEL_REMOTE_PORT="remote_port" \
        amontaigu/tunnel

EOF
else 
    echo >&2 "[INFO] Your configuration seems correct"
fi

# Exec main command
echo >&2 "[INFO] ---------------------------------------------------------------"
echo >&2 "[INFO] Starting tunnel..."
echo >&2 "[INFO] ---------------------------------------------------------------"
exec sshpass -p $GATEWAY_PWD ssh -o StrictHostKeyChecking=no -N -X -L \*:$TUNNEL_LOCAL_PORT:$TUNNEL_REMOTE_HOST:$TUNNEL_REMOTE_PORT $GATEWAY_USER@$GATEWAY_HOST
