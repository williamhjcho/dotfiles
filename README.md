![logo](./files/logo.png "Logo")

# whjc's Dotfiles

## 1. Make sure you have a system python configured

Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).

- Run the following command to add Python 3 to your PATH: `export PATH="$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH"`
- Upgrade Pip: `sudo pip3 install --upgrade pip`
- Install [Ansible][ansible-install]: `pip3 install ansible`

## 2. Clone [dotfiles repo][dotfiles-repo]

```shell
git clone https://github.com/williamhjcho/dotfiles ~/dotfiles
```

## 3. Run the ansible playbook

From inside `ansible/` dir

```shell
# installs the required roles
ansible-galaxy install -r requirements.yaml

# run the playbook
./install.sh

# or run the playbook with specific tags
./install.sh --homebrew --dotfiles
```

## 4. Manual settings

Secrets

- Create/copy the `.env.personal` secrets file into `~/.env.personal`

System Preferences

- Keyboard > Modifier Keys > Caps to Left Ctrl

**Tmux**

Each machine might need their own tmux configuration, so create a copy of one of the `bin/tmux.sh` file(s) and adjust accordingly.

---

[SSH setup][ssh-setup]

```shell
ssh-keygen -t ed25519 -C "your_email@example.com"

# start ssh-agent in the background
eval "$(ssh-agent -s)"
````

edit `~/.ssh/config` to load keys & store in keychain

```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

```shell
# add the ssh to the agent
ssh-add --apple-use-keychain "~/.ssh/id_ed25519"
```

Add the new SSH public key to GitHub (it can be used for both authentication and signing)

Test if the SSH is working

```shell
ssh -T git@github.com
```

Post setup

- Install latest node `nvm install node`
- Install latest python `pyenv install 3.12` (also re-setup ansible dependencies, i.e. pip)

## 5. Everyday usage

Copy/edit one of the tmux files then symlink to home `ln -s ~/dotfiles/bin/<tmux-file>.sh ~/tmux.sh`
Then initialize tmux with pre-configured session: `~/tmux.sh`

[ansible-install]: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
[dotfiles-repo]: https://github.com/williamhjcho/dotfiles
[ssh-setup]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
