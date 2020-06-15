#!/bin/bash
# Easy venv
# Functions to make managing Python virtual environments easy

add_kernel() {
    # Add the active environment as a Jupyter kernel
    # Assumes python and ipykernel is installed
    # Args: kernel_name
    #     KERNEL_NAME: The name of the kernel to be created
    if [ "$#" -ne 1 ]; then
        echo "❓ Illegal number of parameters"
        echo "Expected 1 parameter -- the kernel name"
        echo
        echo "Usage: activate_venv [KERNEL_NAME]"
        return 1
    fi
    local KERNEL_NAME="$1"
    if python -m ipykernel install --user --name="${KERNEL_NAME}"; then
        echo "🌽 Kernel ${KERNEL_NAME} created"
        return 0
    else
        echo "Kernel creation failed"
        return 1
    fi
}

del_kernel() {
    # Remove a kernel from Jupyter
    # Assumes python and jupyterlab is installed
    # Args: kernel_name
    if [ "$#" -ne 1 ]; then
        echo "❓ Illegal number of parameters"
        echo "Expected 1 parameter -- the kernel name"
        return 1
    fi
    local KERNEL_NAME="$1"
    if jupyter kernelspec uninstall "${KERNEL_NAME}"; then
        echo "🗑 Kernel ${KERNEL_NAME} removed"
        return 0
    else
        echo "❌ Kernel removal failed"
        return 1
    fi
}

make_venv() {
    # Make a new Python venv
    # Assumes Python is installed
    # Args:
    #    prompt name (optional) By default left blank
    #    directory name (optional) By default set to ".venv"
    if [ "$#" -gt 2 ]; then
        echo "❓ Too many paremeters"
        echo "Expected 2 optional parameters -- the prompt and directory name"
        echo
        echo "Usage: make_venv [PROMPT_NAME] [DIRECTORY]"
        return 1
    else
        local prompt_name="${1:-.venv}"
        local directory="${2:-.venv}"
        if python -m venv --prompt="${prompt_name}" "${directory}"; then
            echo "📦 $(python --version) virtual environment created in $(pwd)/${directory}"
            return 0
        else
            echo "❌ Virtual environment creation failed"
            return 1
        fi
    fi
}

activate_venv() {
    # Activate a Python virtual environment
    # Args:
    #    directory name (optional) By default is set to ".venv"
    if [ "$#" -gt 1 ]; then
        echo "❓ Too many paremeters"
        echo "Expected 1 optional parameter -- the directory name"
        echo
        echo "Usage: activate_venv [DIRECTORY]"
        return 1
    else
        local directory="${1:-.venv}"
        if source "${directory}/bin/activate"; then
            echo "📦 $(python --version) virtual environment in $(pwd)/${directory} activated"
            return 0
        else
            echo "❌ Virtual environment activation failed"
            return 1
        fi
    fi
}
