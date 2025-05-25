function mkvenv
    set -l VENV_DIR "$HOME/.venv"
    set -l venv_name $argv[1]
    if test -z "$venv_name"
        echo "Usage: mkvenv <venv_name>"
        return 1
    end

    python3 -m venv "$VENV_DIR/$venv_name"
    if test $status -ne 0
        echo "Failed to create virtual environment '$venv_name'."
        return 1
    end

    echo "Virtual environment '$venv_name' created successfully."
end
