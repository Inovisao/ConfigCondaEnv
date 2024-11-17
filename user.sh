#!/bin/bash

# Instale o Anaconda no seguinte path:
condaInstallPath="/opt/anaconda3"

# Cria um novo grupo na maquina chamado anaconda
sudo addgroup anaconda

# Adiciona usuario atual para o grupo anaconda
sudo adduser $USER anaconda

# Define dono da pasta do Anaconda para o grupo anaconda
sudo chgrp -r anaconda /opt/anaconda3

# Define permissoes da pasta do Anaconda para membros do grupo anaconda
# 2775 = Somente sudo, dono e membros do grupo podem acessar a pasta e seus filhos,
# e todos os arquivos modificados ou criados terao como dono o grupo, para manter compartilhamento
sudo chmod 2775 -r /opt/anaconda3

# Bloco de inicialização do Conda a ser adicionado ao ~/.bashrc
# Baseado no codigo de https://github.com/matbinder/secure-multi-user-conda
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