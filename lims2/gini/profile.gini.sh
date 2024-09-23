export GINI_ENV=development
export PATH="/data/gini-modules/gini/bin:$PATH"
export GINI_MODULE_BASE_PATH="/data/gini-modules"
export LESSCHARSET=utf-8

if type __git_ps1 >/dev/null 2>&1; then
    __iamfat_git_ps1() {
        local ps1=$(__git_ps1 ' %s ')
        if [[ -n $ps1 ]]; then
            echo -e "${2}${ps1}${3}"
        else
            echo -e "${1}"
        fi
    }

    __iamfat_ps1() { 
        local b='\[\033[0;30;44m\]'
        local b2g='\[\033[0;34;42m\]\[\033[30m\] '
        local g2y='\[\033[0;32;43m\]\[\033[30m\] '
        local y2g='\[\033[0;33;42m\]\[\033[30m\] '
        local y2none='\[\033[0;33m\]\[\033[0m\] '
        local g2none='\[\033[0;32m\]\[\033[0m\] '

        local host="  \h "
        local workdir=" \w "
        local git="\$(__iamfat_git_ps1 '${g2none}' '${g2y}' '${y2none}')"
        echo "${b}${host}${b2g}${workdir}${git}"
    }

    export PS1=$(__iamfat_ps1)
fi
