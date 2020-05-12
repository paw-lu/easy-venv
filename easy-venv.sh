# Easy venv
# Functions to make managing Python virtual environments easy

add_kernel () {
    # Add the active environment as a Jupyter kernel
    # Assumes python and ipykernel is installed
    # Args: kernel_name
    if [ "$#" -ne 1 ]; then
        echo "❓ Illegal number of parameters"
        echo "Expected 1 parameter -- the kernel name"
        return 1
    fi
    local KERNEL_NAME="$1"
    python -m ipykernel install --user --name="${KERNEL_NAME}"
    if [ "$?" -eq "0" ]; then
        echo "🌽 Kernel ${KERNEL_NAME} created"
        return 0
    else
        echo "Kernel creation failed"
        return 1
    fi
}

del_kernel () {
    # Remove a kernel from Jupyter
    # Assumes python and jupyterlab is installed
    # Args: kernel_name
    if [ "$#" -ne 1 ]; then
        echo "❓ Illegal number of parameters"
        echo "Expected 1 parameter -- the kernel name"
        return 1
    fi
    local KERNEL_NAME="$1"
    jupyter kernelspec uninstall "${KERNEL_NAME}"
    if [ "$?" -eq "0" ]; then
        echo "🗑 Kernel ${KERNEL_NAME} removed"
        return 0
    else
        echo "❌ Kernel removal failed"
        return 1
    fi
}

make_venv () {
    # Make a new Python venv
    # Assumes Python is installed
    # Args:
    #    prompt name (optional) By default left blank
    #    directory name (optional) By default set to ".venv"
    if [ "$#" -gt 2 ]; then
        echo "❓ Too many paremeters"
        echo "Expected 2 optional parameters -- the prompt and directory name"
        return 1
    elif [ "$#" -gt 0 ]; then
        local PROMPT_NAME="$1"
        local DIRECTORY="${2:-.venv}"
        python -m venv --prompt="${PROMPT_NAME}" "${DIRECTORY}"
    else
        python -m venv .venv
    fi
    if [ "$?" -eq "0" ]; then
        echo "📦 `python --version` virtual environment created in `pwd`/${DIRECTORY}"
        return 0
    else
        echo "❌ Virtual environment creation failed"
        return 1
    fi
}
