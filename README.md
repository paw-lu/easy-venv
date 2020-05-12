# Easy venv

Shell functions to manage Python virtual environments

A lot of a Python developer's time
is spent wrangling virtual environments.
However,
the commands to do so are [notoriously](https://venv.netlify.app/) [difficult](http://veekaybee.github.io/2020/02/18/running-jupyter-in-venv/) to remember,
and surprisingly harder to find than you would like.

## Usage

Make a Python virtual env
with a prompt named "test-env"

```sh
~
❯ make_venv test-env
📦 Python 3.8.2 virtual environment created in /Users/paulo/.venv

~
❯ activate_venv
📦 Python 3.8.2 virtual environment in /Users/paulo/.venv activated

test-env ❯
```

Note that you should be in the same directory that you ran `make_venv`
in order for `activate_venv` to succceed.

Now say
you have a separate environment that has [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/) installed,
and you would like to make `test-env` available as a kernel in that environment. Run

```sh
~
test-env ❯ python -m pip install ipykernel

~
test-env ❯ add_kernel test-env
🌽 Kernel test-env created
```

`test-env` should now be available
as one of the avaiable kernels to select in JupyterLab.

Let's assume JupyterLab is installed in an environment named `notebook`.
First activate the environment.
Then, to remove `test-env` from the avaiable kernels run

```sh
~
notebook ❯ del_kernel test-env
🗑 Kernel test-env removed
```

## Installation

Run

```shell
~
❯ git clone https://github.com/pscosta5/easy-venv.git ~/.easy-venv
```

now add

```zsh
source "$HOME/.easy-venv/easy_venv.sh"
```

to your `.zshrc`/`.bashrc`/etc.
