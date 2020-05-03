#!/bin/bash

clifunc__cmd_space_ls(){
    # TODO now-here
    clifunc__print_help_space_ls
}

clifunc__cmd_bloon_ls(){
    clifunc__print_help_bloon_ls
}

clifunc__cmd_stop(){
    # do nothing
    # -------------------------------------------------- following: passed input validation
    returnStr=$(hero_func_call stop '{}')
    if [ "__ERR_BLOON_HAS_NOT_STARTED_YET__" == "$returnStr"  ]; then exit 1; fi
    # -------------------------------------------------- following: gotten HeroFuncParsor return correctly
    # just stop the app, no any output
    exit 0
}

clifunc__cmd_login(){
    clifunc__cmd_account_login $@
}

clifunc__cmd_logout(){
    clifunc__cmd_account_logout
}

clifunc__cmd_install(){
    $BLOON_CLI_HOME/lib/bash/__clifunc__cmd_install.sh
}

clifunc__cmd_upgrade(){
    # TODO to impl.
    clifunc__print_help_upgrade
}

clifunc__cmd_account_detail(){
    # do nothing
    # -------------------------------------------------- following: passed input validation
    current_login_acc="$(clifunc__cmd_account_current | awk '{print $2}')"
    if [ "NO_ONE_LOGGED_IN" == "$current_login_acc" ]; then
        echo "[bloon] NO_ONE_LOGGED_IN"
        exit 0
    fi

    returnStr=$(hero_func_call getAccInfo '{"with_photo": '$TO_SHOW_PROFILE_PHOTO'}')
    if [ "__ERR_BLOON_HAS_NOT_STARTED_YET__" == "$returnStr"  ]; then exit 1; fi
    # -------------------------------------------------- following: gotten HeroFuncParsor return correctly
    acc_info_in_one_str="$returnStr"
    echo "$acc_info_in_one_str" # keep all format output from func_parsor
}

clifunc__cmd_account_logout(){
    # do nothing
    # -------------------------------------------------- following: passed input validation
    current_login_acc="$(clifunc__cmd_account_current | awk '{print $2}')"
    if [ "NO_ONE_LOGGED_IN" == "$current_login_acc" ]; then
        echo "[bloon] NO_ONE_LOGGED_IN"
        exit 0
    fi
    
    returnStr=$(hero_func_call logout '{}')
    if [ "__ERR_BLOON_HAS_NOT_STARTED_YET__" == "$returnStr"  ]; then exit 1; fi
    # -------------------------------------------------- following: gotten HeroFuncParsor return correctly
    login_state_str=$returnStr
    echo "[bloon] "$login_state_str
}

clifunc__cmd_account_current(){
    # do nothing
    # -------------------------------------------------- following: passed input validation
    returnStr=$(hero_func_call getCurrentLoginAcc '{}')
    if [ "__ERR_BLOON_HAS_NOT_STARTED_YET__" == "$returnStr"  ]; then exit 1; fi
    # -------------------------------------------------- following: gotten HeroFuncParsor return correctly
    current_login_acc=$returnStr
    if [ "$current_login_acc" == "" ]; then
        echo "[bloon] NO_ONE_LOGGED_IN"
    else
        echo "[bloon] "$current_login_acc
    fi
}

clifunc__cmd_account_login(){
    if [ $# -lt 1 ]; then
        echo >&2 "[bloon] 'login' command requires at least 1 arguments."
        echo >&2 "[bloon] See 'bloon account login --help'."
        exit 1
    fi
    # -------------------------------------------------- following: passed input validation
    acc_str="$1"
    read -s -p "[bloon] Please enter password: " pwd_str
    echo
    echo "[bloon] Loging in, please wait..."
    echo

    returnStr=$(hero_func_call login '{"acc_str":"'"$acc_str"'", "pwd_str":"'"$pwd_str"'"}')
    if [ "__ERR_BLOON_HAS_NOT_STARTED_YET__" == "$returnStr"  ]; then exit 1; fi
    # -------------------------------------------------- following: gotten HeroFuncParsor return correctly
    login_state_str=$returnStr
    if [ "OTHER_ACCOUNT_LOGIN" == "$login_state_str" ]; then
        echo "[bloon] Someone has logged-in, please log out first."
        echo "[bloon] See 'bloon account current' for checking who is the current logged-in one."
    else
        echo "[bloon] "$login_state_str
    fi
}

clifunc__cmd_start(){
    status_str="$(clifunc__cmd_status | awk '{print $2}')"
    if [ "OFF" == "$status_str" ]; then
        echo "[bloon] Starting BLOON..."
        
        ./lib/bash/hero-launcher.sh
        
        echo "[bloon] BLOON daemon started."
        echo "[bloon] Use 'bloon status' to check status."
    
    else
        echo "[bloon] BLOON has started."
        echo "[bloon] Use 'bloon status' to check status."

    fi
}

clifunc__show_version(){
    # do nothing
    # -------------------------------------------------- following: passed input validation
    returnStr=$(hero_func_call getHeroVersion '{}')
    if [ "__ERR_BLOON_HAS_NOT_STARTED_YET__" == "$returnStr"  ]; then exit 1; fi
    # -------------------------------------------------- following: gotten HeroFuncParsor return correctly
    version_name_str=$returnStr
    echo "[bloon] "$version_name_str
}

# --------------------------------------------------
# Utils, modify with caution
# --------------------------------------------------

hero_func_call(){
    statusStr=$(clifunc__cmd_status | awk '{print $2}')
    if ! [ "ON" == "$statusStr" ]; then
        echo >&2 "[bloon] BLOON has not started yet."
        echo >&2 "[bloon] Use 'bloon start' to start BLOON."
        echo "__ERR_BLOON_HAS_NOT_STARTED_YET__"
    else
        funcName="$1"
        paramsJsonObjStr="$2"
        returnStr=$(python3 ./lib/py/hero_connector.py "$funcName" "$paramsJsonObjStr")
        echo "$returnStr"
    fi
}

clifunc__cmd_status(){
    pid_of_hero=$(ps aux | grep -v grep | grep "bloond" | awk '{print $2}')
    if [ -z "$pid_of_hero" ]; then
        echo "[bloon] OFF"

    else
        tmpToken="$(cat /dev/urandom | head | md5sum | awk '{print $1}')"
        # To do echo test for checking websocket to hero is normal
        returnStr=$(python3 ./lib/py/hero_connector.py echo '{"echo_str": "'$tmpToken'"}')
        if [ "$returnStr" == "__ConnectionRefusedError__" ]; then
            echo "[bloon] PENDING"
        else
            echoStr="$returnStr"
            if [ "$echoStr" == "$tmpToken" ]; then
                echo "[bloon] ON"
            else
                echo "[bloon] PENDING"
            fi
        fi
    fi
}