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
ansible-playbook main.yaml --ask-become-pass (--verbose) (--tags=)
```

## 4. Manual settings

System Preferences

- Keyboard > Modifier Keys > Caps to Left Ctrl

Iterm2

- Set `~/.dotfiles/iterm2/` as the default profile path

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

Add the new SSH public key to GitHub

Test if the SSH is working

```shell
ssh -T git@github.com
```

---

[GPG setup][gpg-setup]

```shell
# generate the key
gpg --full-generate-key

# print the gpg key info
gpg --list-secret-keys --keyid-format=long

# print the gpg key in armor format
gpg --armor --export <key-id>
```

Then add to GitHub

[ansible-install]: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
[dotfiles-repo]: https://github.com/williamhjcho/dotfiles
[ssh-setup]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
[gpg-setup]: https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
