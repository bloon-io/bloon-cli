#!/bin/bash

clifunc__print_help_global(){
    cat << EOF

Usage:  bloon [OPTIONS] COMMAND

Options:
    -v, --version             Print version information and quit
    -h, --help                Print this help document

Management Commands:
    account                   Manage account
    bloon                     Manage bloons (TODO not support yet)
    space                     Manage spaces (TODO not support yet)
    sharelink                 Manage sharelinks (TODO not support yet)
    directlink                Manage direct links (TODO not suppor yet)
    device                    Manage current device settings (TODO not support yet)

Commands:
    start                     Start BLOON daemon
    stop                      stop BLOON daemon
    status                    Show status of BLOON daemon
    login                     Log in
    logout                    Log out
    install                   Install BLOON daemon which matches current bloon-cli (TODO not support yet)
    upgrade                   Upgrade bloon-cli & matched BLOON daemon (TODO not support yet)
    
Run 'bloon COMMAND --help' for more information on a command.

EOF
}

clifunc__print_help_account(){
    cat << EOF

Usage:  bloon account [OPTIONS] COMMAND 

Options:
    -h, --help                Print this help document

Commands:
    login                     Log in
    logout                    Log out
    current                   Show current logged-in account
    detail                    Show detail information of current logged-in account
    
Run 'bloon account COMMAND --help' for more information on a command.

EOF
}

clifunc__print_help_space(){
    cat << EOF

Usage:  bloon space [OPTIONS] COMMAND 

Options:
    -h, --help                Print this help document

Commands:
    ls                        List spaces (TODO not support yet)

Run 'bloon space COMMAND --help' for more information on a command.

EOF
}

clifunc__print_help_bloon(){
    cat << EOF

Usage:  bloon bloon [OPTIONS] COMMAND 

Options:
    -h, --help                Print this help document

Commands:
    ls                        List bloons (TODO not support yet)

Run 'bloon bloon COMMAND --help' for more information on a command.

EOF
}

clifunc__print_help_space_ls(){
    cat << EOF

(TODO not support yet)

EOF
}

clifunc__print_help_bloon_ls(){
    cat << EOF

(TODO not support yet)

EOF
}

clifunc__print_help_status(){
   cat << EOF

Usage:  bloon status

To show status of BLOON daemon. The output could be "ON", "OFF" or "PENDING".

EOF
}

clifunc__print_help_start(){
    cat << EOF

Usage:  bloon start

To start BLOON daemon.

EOF
}

clifunc__print_help_account_login(){
    cat << EOF

Usage:  bloon account login [OPTIONS] BLOON_ACCOUNT

To log in. BLOON_ACCOUNT is your account (email) for loging in to BLOON.

Options:
    -h, --help                Print this help document

EOF
}

clifunc__print_help_account_logout(){
    cat << EOF

Usage:  bloon account logout

To log out.

EOF
}

clifunc__print_help_account_current(){
    cat << EOF

Usage:  bloon account current

To show current logged-in account or print "NO_ONE_LOGGED_IN" if no account has logged-in.

EOF
}

clifunc__print_help_account_detail(){
    cat << EOF

Usage:  bloon account [OPTIONS] detail

To show detail information of current logged-in account or print "NO_ONE_LOGGED_IN" if no account has logged-in.

Options:
    --photo                   Print profile photo in JPEG format with BASE64 string
    -h, --help                Print this help document

EOF
}

clifunc__print_help_login(){
    cat << EOF

Usage:  bloon login [OPTIONS] BLOON_ACCOUNT

To log in. BLOON_ACCOUNT is your account (email) for loging in to BLOON.

This is totally the same as 'bloon account login'.

Options:
    -h, --help                Print this help document

EOF
}

clifunc__print_help_logout(){
    cat << EOF

Usage:  bloon logout

To log out.

This is totally the same as 'bloon account logout'.

EOF
}

clifunc__print_help_stop(){
    cat << EOF

Usage:  bloon stop

To stop BLOON daemon.

EOF
}

clifunc__print_help_install(){
    cat << EOF

TODO not support yet

EOF
}

clifunc__print_help_upgrade(){
    cat << EOF

TODO not support yet

EOF
}