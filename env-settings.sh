#!/bin/bash

APP_PATH=$(dirname "$(realpath "$0")")

rm -f /etc/bash_completion.d/bloon-completion.sh
ln -s $APP_PATH/etc/bloon-completion.sh /etc/bash_completion.d

cat << EOF > /etc/profile.d/bloon-path.sh
export APP_PATH=$APP_PATH
export PATH=\$APP_PATH/bin:\$PATH
EOF

