# Gestão Educacional — Atividades em tempo real

## O que já funciona
- Área do aluno.
- Cadastro simples por nome e turma.
- Lista de atividades por turma.
- Questões de múltipla escolha.
- Correção automática.
- Registro de nota e respostas no banco.
- Painel do professor.
- Entregas aparecendo em tempo real sem LocalStorage.
- Atualização em tempo real usando Supabase Realtime.

## Configuração
1. Crie um projeto no Supabase.
2. Abra o SQL Editor e execute `schema.sql`.
3. No projeto, copie a URL e a chave `anon`.
4. Abra `index.html` e substitua:
   SUPABASE_URL
   SUPABASE_ANON_KEY
5. Publique a pasta em qualquer hospedagem estática (GitHub Pages, Netlify, Vercel etc.).

## Importante para uma versão escolar real
Esta versão é um MVP funcional. Antes de colocar dados reais de alunos:
- ative autenticação;
- crie contas/perfis separados para professor e aluno;
- restrinja as políticas RLS por usuário/turma;
- não deixe o painel do professor aberto para qualquer visitante;
- adicione LGPD, consentimento e controle de acesso adequados.

## Formato das questões
Uma questão por linha:
Pergunta | Alternativa A | Alternativa B | Alternativa C | Alternativa D | Letra correta

Exemplo:
Quanto é 2+2? | 3 | 4 | 5 | 6 | B
