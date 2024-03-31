#!/bin/bash

# Check ROOT_PASSWD ENV, and Update root Password.
if [ ! -z "$ROOT_PASSWD" ]; then
    echo "root:$ROOT_PASSWD" | chpasswd
fi

# Check MY_USER ENV, and Create User.
if [ ! -z "$MY_USER" ]; then
    useradd -m -s /bin/bash "$MY_USER"
    echo 'whoami ALL=NOPASSWD: ALL' > /etc/sudoers.d/whoami
    echo "${MY_USER}:${MY_USER_PASSWD}" | chpasswd
fi

/bin/bash
