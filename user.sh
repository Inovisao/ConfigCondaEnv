#!/bin/bash

### PARA USUARIOS JA EXISTENTES
# Rode esses comandos para cada usuario

# Verifique que voce nao possua Anaconda instalado localmente, para evitar conflitos.
# Caso ja esteja instalado localmente, lembre-se de atualizar seu ~/.bashrc com 
# o comando do anaconda, ou manualmente modificando o arquivo de texto e
# retirando o bloco de codigo que inicializa o Anaconda localmente.
# Siga as instrucoes linkadas no README para desinstalar corretamente.

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

# Adiciona usuario atual para o grupo anaconda
sudo adduser $USER anaconda

# Adiciona o bloco de inicialização Conda ao ~/.bashrc
echo "$anacondaInit" >> ~/.bashrc