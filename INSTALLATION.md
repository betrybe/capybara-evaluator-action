# Capybara Evaluator Action for Tryber projects

Aplicação para teste e correção dos projetos dos estudantes da Trybe utilizando Capybara.

Esta aplicação vai executar os testes a partir do nome do repositório dos estudantes, que deve ser obtido via ENV VAR.

## Guia de instalação do ambiente de desenvolvimento

Este guia irá te ajudar a instalar e configurar a aplicação do zero.

1. Clone o projeto: `git clone git@github.com:betrybe/capybara-evaluator-action.git`
2. Entre em seu diretório: `cd capybara-evaluator-action/`
3. Execute o passo a passo abaixo para realizar a instalação das dependências

### Passo a passo

> Ubuntu:

- Instale as dependências do ruby

```
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn
```

- Instale o geckodriver

```
wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz
tar -xvzf geckodriver*
sudo chmod +x geckodriver
sudo mv geckodriver /usr/local/bin/
rm geckodriver-v0.26.0-linux64.tar.gz
```

- Instale o ruby utilizando um gerenciador de versões a sua escolha (rvm ou rbenv, por exemplo)

    - Utilizando rvm

    ```
    sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    rvm install 2.7.0
    rvm use 2.7.0 --default
    ruby -v
    ```

    - Utilizando rbenv

    ```
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    exec $SHELL

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    exec $SHELL

    rbenv install 2.7.0
    rbenv global 2.7.0
    ruby -v
    ```

- Instale o bundler e as gems do projeto

```
gem install bundler
bundle install
```

> Mac OS X:

- Instale o geckodriver

```
brew cask install firefox
wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-macos.tar.gz
tar -xvzf geckodriver*
sudo chmod +x geckodriver
sudo mv geckodriver /usr/local/bin/
rm geckodriver-v0.26.0-macos.tar.gz
```

- Instale o ruby utilizando um gerenciador de versões a sua escolha (rvm ou rbenv, por exemplo)

    - Utilizando rvm

    ```
    sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | sudo bash -s stable
    sudo usermod -a -G rvm `whoami`
    if sudo grep -q secure_path /etc/sudoers; then sudo sh -c "echo export rvmsudo_secure_path=1 >> /etc/profile.d/rvm_secure_path.sh" && echo Environment variable installed; fi


    rvm install 2.7.0
    rvm use 2.7.0 --default
    ruby -v
    ```

    - Utilizando rbenv

    ```
    brew install rbenv ruby-build

    # Add rbenv to bash so that it loads every time you open a terminal
    echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
    source ~/.bash_profile

    # Install Ruby
    rbenv install 2.7.0
    rbenv global 2.7.0
    ruby -v
    ```

- Instale o bundler e as gems do projeto

    ```
    gem install bundler
    bundle install
    ```

### Executando os testes do corretor

- Antes de executar os testes do corretor é necessário clonar o repositório a ser corrigido dentro do diretório `spec` e clonar o repositório dos testes dentro do repositório a ser corrigido

    ```
    cd spec/
    git clone git@github.com:tryber/<project-repo-name>.git
    cd <project-repo-name>
    git clone git@github.com:tryber/<project-repo-name>-tests.git
    cd ../../
    ```

- Para executar os testes basta utilizar o `rspec` com as variáveis de ambiente necessárias

    ```
    GITHUB_REPOSITORY=<project-repo-name> rspec
    ```

### Executando os testes do corretor com Docker

Caso queira executar o corretor com o Docker para não precisar configurar seu ambiente local, você pode executar os passos abaixo:

1. [Instale o docker](https://docs.docker.com/install/)
2. Clone o projeto: `git clone git@github.com:betrybe/capybara-evaluator-action.git`
3. Entre no diretório dos testes do corretor: `cd capybara-evaluator-action/spec/`
4. Clone o repositório a ser corrigido: `git clone git@github.com:tryber/<project-repo-name>.git`
5. Clone o repositório dos testes dentro do repositório a ser corrigido: `cd <project-repo-name> && git clone git@github.com:tryber/<project-repo-name>.git`
6. Volte ao diretório raiz do corretor: `cd ../../`
7. Crie a imagem do docker: `sudo docker build -t capybara-evaluator .`

Após configurar o docker, para executar os testes basta utilizar o comando abaixo:

```
sudo docker run --env GITHUB_REPOSITORY='<project-repo-name>' capybara-evaluator
```
