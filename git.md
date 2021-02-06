# GIT

## Instalar Git for Linux
### Terminal
	sudo apt update
	sudo apt install git -y

## Configurar GitHub
### Terminal
##### Setar usuário
	git config --global user.name "user_name"

##### Setar email
	git config --global user.email "email_id"

##### Listar configurações
	git config --list

### Verificar estado dos arquivos/diretórios
	git status

## Criar repositorio local
### Terminal
	echo "# scripts" >> README.md
	git init
	git add README.md
	git commit -m "primeiro-comentario"
	git branch -M branch-folder-master
	git remote add origin https://github.com/armandocovre/RADIOATIVO.git
	git push -u origin branch-folder-master


## Acessar no GitHub via browser e criar repositório


## "Upload" dos arquivos para repositorio
### Terminal
	git remote add origin https://github.com/armandocovre/RADIOATIVO.git
	git branch -M branch-folder-master
	git push -u origin branch-folder-master



## Criar novo branch
### Terminal
	git checkout branch-folder-master
	git commit -m "comentario-branch-nova"
	git push origin branch-folder-master


### Remover arquivo/diretório
##### Remover arquivo
	git rm meu_arquivo.txt

##### Remover diretório
	git rm -r diretorio


##### Exibir histórico
	git log

### Exibir os repositórios remotos
	git remote
	git remote -v

##### Atualizar os arquivos no branch atual
	git pull
	
##### Buscar as alterações, mas não aplica-las no branch atual
	git fetch


###### Listar branches
	git branch

###### Listar branches com informações dos últimos commits
	git branch -v