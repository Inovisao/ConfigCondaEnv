# ConfigCondaEnv
Repositório simples com comandos e instrucoes que configura o ambiente conda do grupo Inovisão em perfis novos.

## Logica
O metodo em que estes comandos funcionam seguem a seguinte logica:
1. Criar, utilizando sudo/root, o Anaconda em um local globalmente alcancavel; neste caso /opt/anaconda3/
2. Criar um grupo de usuarios chamado Anaconda, onde todos os usuarios que irao usufruir do Anaconda compartilhado devem fazer parte.
3. Mudar o dono da pasta /opt/anaconda3/ para o GRUPO Anaconda.
4. Mudar as permissoes da pasta do Anaconda para que apenas o root, dono e membros do grupo possam ler, escrever e modificar seus conteudos, e todo conteudo novo criado ou modificado terao estas mesmas configuracoes.
5. Inserir usuarios no grupo Anaconda e mudar o Path para a instalacao Anaconda global.
6. Faca as modificacoes necessarias para os usuarios, e reinicie o terminal. Caso ainda nao apareca, reinicie a maquina.

### Para novos usuarios
1. Modifique `/etc/adduser.conf` como sudo, e acionamos a flag `ADD_EXTRA_GROUP=1` e adicionamos o grupo Anaconda ao `EXTRA_GROUPS`
2. Modifique o arquivo `/etc/skel/.bashrc` com os comandos necessarios

### Para usuarios ja existentes
1. Verifique se o Anaconda ja esta instalado. Caso esteja, desinstale ele seguindo [estas instrucoes](https://docs.anaconda.com/anaconda/install/uninstall/).
2. Uma vez que Anaconda nao esteja mais disponivel para o usuario, adicione o usuario ao Grupo Anaconda.
3. Modifique o arquivo `~/.bashrc` com os comandos necessarios.

## Conclusao
Apos este processo, o usuario tera acesso a instalacao global do Anaconda em sua maquina. Todos os usuarios podem, entao, criar e compartilhar ambientes, e limpar ou deletar ambientes sem limitacoes.