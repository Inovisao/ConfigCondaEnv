#!/bin/bash

# Adiciona o usuário atual ao grupo "inovisao"
sudo adduser "$USER" inovisao

# Define permissões de sudo para chown sem senha
permission="$USER ALL=(ALL:ALL) NOPASSWD: /bin/chown"

# Bloco de inicialização do Conda a ser adicionado ao ~/.bashrc
anacondaInit=$(cat << 'EOF'
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/inovisao/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/inovisao/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/inovisao/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/inovisao/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
EOF
)

# Bloco para alterar o proprietário de /home/inovisao/anaconda3, a ser adicionado ao ~/.bashrc
mudaProprietario=$(cat << 'EOF'
sudoPW=inovisao
echo $sudoPW | sudo -S -u inovisao chown -R inovisao:inovisao /home/inovisao/anaconda3
unset sudoPW
EOF
)

# Adiciona permissões sudo ao arquivo inovisao-permission
echo "$permission" | sudo tee -a /etc/sudoers.d/inovisao-permission > /dev/null

# Adiciona o bloco de inicialização Conda e mudaProprietario ao ~/.bashrc
echo "$anacondaInit" >> ~/.bashrc
echo "$mudaProprietario" >> ~/.bashrc