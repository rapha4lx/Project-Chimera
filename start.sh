#!/bin/bash

sudo apt update && sudo apt upgrade -y

get_last_command_status_code() {
    if [ $? -eq 0 ]; then
        return 1
    fi
    return 0
}

packed_installed() {
    local packed_name=$1

    if [ -z "$packed_name" ]; then
        echo "Erro: first parameter not inserted" >&2
        return 2
    fi

    if ! pip show $packed_name > /dev/null 2>&1; then
        echo "❌ Error: $packed_name not installed"
        return 0
    else
        echo "✔ $packed_name already installed"
        return 1
    fi
}

install_packed() {
    local packed_name=$1

    if [ -z "$packed_name" ]; then
        echo "Erro: first parameter not included"
        exit 1
    fi

    if get_last_command_status_code; then
        return 1
    fi

    if ! pip install $packed_name; then
        echo "❌ Error when install '$packed_name'"
    else
        echo "✔ Installed with success '$packed_name'"
    fi
}

install_pip_packed() {
    local packed_name=$1
    if [ -z "$packed_name" ]; then
        echo "❌ Erro: The packed name parameter not inserted" >&2
        return 0
    fi

    if packed_installed "requests"; then
        install_packed "requests"
    fi
}

apt_install() {
    local apt_name="$1"

    
}

VENV_DIR=".venv"

echo "Verifing if venv exist..."

if ! python3 -m venv --help > /dev/null 2>&1; then
    echo "❌ Error: Python 3 or 'venv' module dont exist."
    echo "please install Python 3 and venv module"
    echo "Run: sudo apt install python3-venv"
    exit 1
fi

if [ -d "$VENV_DIR" ]; then
    echo "✔ Venv exist in this folder '$VENV_DIR'."
else
    echo "Creating venv..."
    python3 -m venv "$VENV_DIR"
fi

if ! [ $? -eq 0 ]; then
    echo "❌ Fail in create venv"
else
    echo "✔ Venv created with success"
fi

echo "🌠 Enter in venv"

source "$VENV_DIR/bin/activate"

install_pip_packed "requests"
#apt_install "conky-all"
