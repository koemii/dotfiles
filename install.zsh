pushd_quiet() {
    local path=$1
    pushd $path > /dev/null 2>&1
}

popd_quiet() {
    popd > /dev/null 2>&1
}

main() {
    readonly local project_dir=`dirname $0` 
    readonly local src_dir=src

    pushd_quiet $project_dir
    if [ $? -eq 0 ]; then
        pushd_quiet $src_dir

        if [ $? -eq 0 ]; then
            readonly local dotfiles=`ls`

            for dotfile in $dotfiles; do
                local full_path="$(cd "$(dirname "$dotfile")" && pwd)/$(basename "$dotfile")"
                ln -i -s $full_path $HOME/.$dotfile
            done
        else
            echo "No dotfiles were found during installation!"
            popd_quiet
            exit 1
        fi
        popd_quiet
    else
        popd_quiet
    fi
}

main