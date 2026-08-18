# Publicação

## Opção simples
Publique o `index.html` em uma hospedagem de site estático.

## Banco
O banco fica no Supabase e o navegador conversa com ele por HTTPS.

## Tempo real
O Realtime acompanha:
- `activities`
- `submissions`

Quando uma entrega é inserida, o painel aberto do professor recebe o evento e atualiza a tela.

## Importante
Para produção, não basta hospedar o HTML. Faça a migração para Supabase Auth + RLS por usuário. O protótipo usa uma autenticação própria somente para demonstrar o fluxo.
