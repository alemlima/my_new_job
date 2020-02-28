# MY NEW JOB

Projeto realizado individualmente para primeira etapa do [Treinadev](https://treinadev.com.br) da [CampusCode](https://campuscode.com.br).

A ideia deste projeto é uma aplicação que simula um portal de vagas de emprego, onde Headhunters podem:
- Cadastrar vagas.
- Ver o perfil dos candidatos que se inscreveram em uma vaga.
- Enviar uma proposta a um ou mais candidatos.
- Recusar uma candidatura enviando um feedback.
- Enviar uma mensagem ao candidato.
- Favoritar um candidato de uma candidatura.
- Encerrar uma vaga.

E Candidatos podem:
- Criar seu perfil.
- Buscar vagas pelo título ou descrição.
- Com o perfil completo, candidatar-se à vagas.
- Receber mensagens dos headhunters
- Receber propostas às candidaturas enviadas.
- Recusar propostas enviando(ou não) um feedback ao headhunter.

Há diversas melhorias que estão em implementação, utilizando os conhecimentos adquiridos na segunda fase do treinamento.

---
### Gems utilizadas

`Ruby 2.6.3`

`Rails 5.2.4`

`rspec-rails 3.9` para testes automatizados.

`devise` para autenticação.

---

### Executando o projeto

Para executar o projeto, tenha o ruby e rails instalados, clone o projeto em uma pasta de sua preferência e dentro desta pasta execute o comando `bin\setup`

Após as configurações e instalação das dependências(se necessário) inicie o servidor com o comando `rails server` e visite o endereço local http://localhost:3000 para acessar a aplicação.

Caso queira executar os testes, rode o comando `rspec` em um terminal na raiz do projeto. Ele mostrará o tempo e quantidade de testes realizados. Caso queira ver os testes, eles estão na pasta `/spec` na raiz do projeto, subdivididos em pastas específicas para os tipos de testes.
