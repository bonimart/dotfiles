function workon
    set -l VENV_DIR "$HOME/.venv"
    set -l venv_name $argv[1]
    if test -z "$venv_name"
        echo "Usage: workon <venv_name>"
        return 1
    end

    set -l venv_path "$VENV_DIR/$venv_name/bin/activate.fish"
    if not test -f "$venv_path"
        echo "Virtual environment '$venv_name' does not exist."
        return 1
    end

    source "$venv_path"
    echo "Activated virtual environment '$venv_name'."
end
