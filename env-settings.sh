#!/bin/bash

APP_PATH=$(dirname "$(realpath "$0")")
BLOON_CLI_HOME=$APP_PATH

rm -f /etc/bash_completion.d/bloon-completion.sh
ln -s $BLOON_CLI_HOME/etc/bloon-completion.sh /etc/bash_completion.d

cat << EOF > /etc/profile.d/bloon-path.sh
export BLOON_CLI_HOME=$BLOON_CLI_HOME
export PATH=\$BLOON_CLI_HOME/bin:\$PATH
EOF

# --------------------------------------------------
/etc/profile.d/bloon-path.sh
/etc/bash_completion.d/bloon-completion.sh
