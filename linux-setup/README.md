# linux-setup.sh

`linux-setup.sh` is a bash script that will install programs and settings that
may be useful to individuals running Debian on WSL.

To run the script, go to the root of this repository and run:

```shell
bash linux-setup/linux-setup.sh
```

It will run through the instructions.

> Note:
>
> At some point, the install process will ask for your Windows username. Please
> get your username by doing the following:
> Open Powershell -> 'PS C:\\Users\\`username`'

As of now, the packages it installs are:

- git
- nodejs
- npm
- gpg

It also installs a `.zshrc` file, which includes some useful configurations,
such as:

- Git repo/branch indicator
- The `cdrive` command, which takes you to your Windows home directory

## Using the `cdrive` command

To use the `cdrive` command, just do the following:

```shell
cdrive
```

It just does what would be:

```shell
cd /mnt/c/Users/[username]
```

Much easier to memorize, huh?
