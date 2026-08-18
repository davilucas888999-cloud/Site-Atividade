# CONFIGURAÇÃO DO FIREBASE — Gestão Educacional

Projeto Firebase:
gestao-76bc3

## 1. Authentication

No Firebase Console:
Authentication > Sign-in method > E-mail/senha > Ativar.

Crie manualmente os dois usuários em Authentication > Users:

### Davi
E-mail de autenticação:
davi702@gestao-76bc3.firebaseapp.com
Senha:
04/04/2013

### Professora
E-mail de autenticação:
gracinha@gestao-76bc3.firebaseapp.com
Senha:
1234

O e-mail de autenticação é usado somente para o login do sistema. O e-mail de contato do aluno fica no documento Firestore.

## 2. Firestore

Crie o Cloud Firestore em modo de produção.

Depois, no Firestore, crie:

users/{UID_DO_DAVI}
users/{UID_DA_GRACINHA}

O UID aparece em Authentication > Users.

Documento do Davi:
{
  "name": "DAVI LUCAS PAULINO DA COSTA",
  "username": "davi702",
  "email": "davilucascosta031@gmail.com",
  "phone": "",
  "className": "702",
  "role": "student"
}

Documento da professora:
{
  "name": "MARIA DAS GRAÇAS DE AMORIM SOUSA SILVA",
  "username": "gracinha",
  "email": "",
  "phone": "",
  "className": "",
  "role": "teacher"
}

## 3. Regras

Cole o conteúdo de firestore.rules na aba Firestore Database > Rules e publique.

As regras são um ponto inicial para este projeto. Antes de uso em produção, é recomendável restringir leituras de usuários/atividades por turma e papel, e ativar App Check.

## 4. Realtime

O painel do professor usa onSnapshot() para ouvir a coleção submissions.
Quando o aluno cria uma entrega, o professor recebe a atualização sem recarregar a página.

## 5. Observação importante

A configuração Web do Firebase fica no HTML. Isso não é uma senha administrativa. A proteção dos dados deve ser feita com Authentication e Firestore Security Rules.

Nunca coloque no site uma Service Account Key ou private key.
