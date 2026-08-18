# Gestão Educacional — versão completa em HTML

O `index.html` é uma interface única com:
- login;
- aluno;
- professor;
- dashboard;
- atividades;
- geração de rascunho a partir de conteúdo;
- revisão;
- publicação;
- respostas;
- notas;
- entregas;
- cadastro de alunos;
- turmas;
- credenciais;
- e-mail;
- atualização em tempo real quando ligado ao Supabase.

## Demonstração pronta

Aluno:
- Nome: DAVI LUCAS PAULINO DA COSTA
- Usuário: davi702
- E-mail: davilucascosta031@gmail.com
- Turma: 702
- Senha: 04/04/2013

Professora:
- Nome: MARIA DAS GRAÇAS DE AMORIM SOUSA SILVA
- Usuário: gracinha
- Senha: 1234

As contas DEMO ficam no JavaScript somente para a demonstração local. Não são um mecanismo seguro para produção.

## Para colocar online de verdade

1. Crie um projeto Supabase.
2. Execute `schema.sql`.
3. Coloque URL e ANON KEY no bloco CONFIG do HTML.
4. Para produção, troque o login demo por Supabase Auth.
5. Use RLS com `auth.uid()`.
6. Crie uma Edge Function para cadastrar usuários, alterar senha e gerar atividades por IA.
7. Nunca coloque `service_role` nem chave de IA no HTML.

## Observação importante sobre a senha padrão

A regra pedida foi:
- aluno: aniversário em DD/MM/AAAA;
- professora: 1234.

Isso está presente apenas como exemplo. Para um sistema real, a senha inicial deve ser temporária e o usuário deve trocá-la no primeiro acesso.
