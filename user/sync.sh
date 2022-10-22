set -e

here=$(realpath $(dirname $0))
homedir=$HOME
homerepl=MyHome
cfgdir=$homedir/.config/Code/User
setting=$cfgdir/settings.json
keybinding=$cfgdir/keybindings.json

do_backup() {
    cat $setting | sed -r "s@$homedir@$homerepl@g" > $here/settings.json
    cp $keybinding $here/
    cp $homedir/.vsc.vimrc .
}

do_restore() {
    mv $homedir/.vsc.vimrc $homedir/.vsc.vimrc.bk
    mv $setting ${setting}.bk
    mv $keybinding ${keybinding}.bk
    cat $here/settings.json | sed -r "s@$homerepl@$homedir@g" > $setting
    cp $here/keybindings.json $keybinding
}

if [[ $# -ne 1 ]]; then
    echo "Expect $0 (restore|backup)"
    exit 1
fi
do_$1
