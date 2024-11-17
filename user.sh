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
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
EOF
)

# Adiciona o bloco de inicialização Conda e mudaProprietario ao ~/.bashrc
echo "$anacondaInit" >> ~/.bashrc
echo "$mudaProprietario" >> ~/.bashrc