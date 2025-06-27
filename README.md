# Desafio de Desenvolvimento Flutter

Este repositório contém a resolução de um desafio técnico para uma vaga de Desenvolvedor Flutter. O objetivo foi criar um aplicativo mobile (Android/iOS) e web com funcionalidades de autenticação (cadastro e login) e uma tela inicial que simula um painel de seguros, integrando uma `WebView` para exibir conteúdo externo.

## 🚀 Tecnologias e Arquitetura

O projeto foi construído utilizando as seguintes tecnologias e padrões:

* **Flutter**: Framework UI para construir aplicativos compilados nativamente para mobile, web e desktop a partir de uma única base de código.
* **Dart**: Linguagem de programação otimizada para UI, desenvolvida pelo Google.
* **Flutter Modular**: Uma solução robusta para gerenciamento de rotas e injeção de dependências, promovendo uma arquitetura modular e escalável.
    * A arquitetura é dividida em módulos (`AuthModule`, `HomeModule`, `CoreModule`), que encapsulam funcionalidades específicas e suas dependências.
* **Riverpod**: Um provedor de estado reativo e seguro para Flutter, que oferece um controle preciso sobre o estado da aplicação, facilitando testes e mantendo a reatividade.
    * Utilizado para gerenciamento de estado global (ex: autenticação do usuário, status de "manter logado").
* **Firebase Authentication**: Serviço do Google Firebase para gerenciar a autenticação de usuários, incluindo registro com e-mail/senha e controle de sessão.
* **flutter_secure_storage**: Para armazenamento seguro de dados sensíveis (como o status "manter logado") no dispositivo (Keychain no iOS, SharedPreferences criptografadas no Android).
* **webview_flutter**: Plugin oficial do Flutter para exibir conteúdo web dentro do aplicativo, com suporte para Android, iOS e Web.
* **Validação de CPF**: Implementação de lógica para validação de CPFs no lado do cliente.

## ✨ Funcionalidades

O aplicativo oferece as seguintes funcionalidades principais:

1.  **Autenticação de Usuário**:
    * **Cadastro**: Permite que novos usuários se registrem utilizando CPF (formatado como e-mail para o Firebase) e senha.
    * **Login**: Autenticação de usuários existentes com CPF e senha.
    * **Manter Conectado**: Opção para persistir a sessão do usuário mesmo após o fechamento do aplicativo.
2.  **Home Page**:
    * Exibe o CPF do usuário logado.
    * Seções de "Cotar e Contratar", "Minha Família" e "Contratados", simulando um painel de seguros.
    * Cards de serviço interativos que, ao serem clicados, abrem uma `WebView` para uma URL externa (`https://jsonplaceholder.typicode.com/`), demonstrando a integração com conteúdo web.
3.  **Drawer de Navegação**:
    * Menu lateral com informações do usuário e opção de logout.
4.  **`WebView` Cross-Platform**:
    * Página dedicada para exibir conteúdo da web, funcionando em Android, iOS e Web.
    * Tratamento de erros e compatibilidade para as diferentes plataformas.

## ⚙️ Como Instalar e Rodar o Projeto

Para executar este projeto em sua máquina local, siga os passos abaixo:

### Pré-requisitos

* **Flutter SDK**: Certifique-se de ter o Flutter SDK instalado e configurado (versão 3.x.x ou superior recomendada).
    * [Instalação do Flutter](https://flutter.dev/docs/get-started/install)
* **Firebase CLI**: Necessário para configurar o Firebase no seu projeto.
    * [Instalação do Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)
* **Configuração do Firebase**:
    1.  Crie um projeto no [Firebase Console](https://console.firebase.google.com/).
    2.  Habilite o **Firebase Authentication** com o método de login **Email/Senha**.
    3.  No seu terminal, navegue até a raiz do projeto e execute:
        ```bash
        flutterfire configure
        ```
        Siga as instruções para associar seu projeto Flutter ao seu projeto Firebase. Isso criará os arquivos `firebase_options.dart` para cada plataforma.

### Passos de Instalação

1.  **Clone o repositório:**
    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    cd <nome_do_seu_repositorio>
    ```

2.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

3.  **Execute o aplicativo:**

    * **Para Mobile (Android/iOS):**
        Certifique-se de ter um emulador ou dispositivo físico conectado e rodando.
        ```bash
        flutter run
        ```

    * **Para Web:**
        ```bash
        flutter run -d chrome # Ou outro navegador de sua preferência
        ```
        Para um build de produção web:
        ```bash
        flutter build web
        ```
        O build estará disponível em `build/web`. Você pode servi-lo usando um servidor web local (ex: `npx serve build/web`).

## 🎥 Demonstrações em Vídeo

Aqui você pode ver o aplicativo em ação nas diferentes plataformas e cenários.

### 1. Fluxo Normal de Login e Navegação

Este vídeo demonstra o processo de cadastro de um novo usuário, o login inicial e a navegação pela Home Page, incluindo o acesso à `WebView`.

[**Link para o Vídeo do Fluxo Normal de Login e Navegação**](URL_DO_VIDEO_AQUI)

---

### 2. Aplicativo Reiniciando Logado

Este vídeo mostra a funcionalidade de "manter conectado", onde o aplicativo é fechado e reaberto, e o usuário permanece logado sem precisar inserir as credenciais novamente.

[**Link para o Vídeo do Aplicativo Reiniciando Logado**](URL_DO_VIDEO_AQUI)

---

### 3. Versão Web Funcionando

Assista a este vídeo para ver o aplicativo em funcionamento na plataforma web, demonstrando a responsividade e a funcionalidade da `WebView`.

[**Link para o Vídeo da Versão Web Funcionando**](URL_DO_VIDEO_AQUI)

---

## 👨‍💻 Contato

Se tiver alguma dúvida ou feedback, sinta-se à vontade para entrar em contato.

**Seu Nome/Contato Profissional**