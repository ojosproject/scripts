# linux-setup.sh

`linux-setup.sh` is a bash script that will install programs and settings that
may be useful to individuals running Debian on WSL.

To run the script, please run:

```shell
bash linux-setup.sh
```

It will run through the instructions.

> Note:
>
> At some point, the install process will ask for your Windows username. Please
> get your username by doing the following:
> Open Powershell -> 'PS C:\\Users\\`username`'

The script will install packages that we will use for the Ojos Project. The
packages we will use are listed in the `APT_PACKAGES` variable.

It also installs a `.zshrc` file, which includes some useful configurations,
such as:

- Git repo/branch indicator
- Custom commands, which
[can be found here](https://docs.ojosproject.org/teams/url/#custom-bash-commands)
