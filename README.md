# Gestão Educacional V2

Sistema escolar com:
- login individual de aluno e professor;
- perfis e turmas;
- atividades publicadas por turma;
- criação de atividade a partir de conteúdo (rascunho para revisão);
- criação/envio de questões prontas;
- respostas e notas;
- painel do professor;
- atualizações em tempo real via Supabase Realtime.

## Configuração rápida

1. Crie um projeto no Supabase.
2. Abra SQL Editor.
3. Execute `schema.sql`.
4. Em `index.html`, preencha `CONFIG` com a URL e a chave anon do Supabase.
5. Publique `index.html` em uma hospedagem estática.

Usuários de demonstração criados pelo SQL:
- professor / 123456
- aluno702 / 123456

## Geração por conteúdo

A interface já possui o fluxo:
Conteúdo -> rascunho -> revisão do professor -> publicação.

O exemplo incluído não chama uma IA externa. Para geração real por IA, a forma correta é criar uma Edge Function/servidor seguro e guardar a chave do provedor de IA somente no servidor, nunca no JavaScript do navegador.

## Segurança — melhoria obrigatória antes de uso real

O SQL contém políticas permissivas para facilitar o protótipo. Elas NÃO são adequadas para dados reais de alunos.

A versão de produção deve usar:
- Supabase Auth;
- `auth.uid()` nas políticas RLS;
- professor limitado às próprias turmas;
- aluno limitado ao próprio perfil e às próprias entregas;
- administração separada;
- auditoria;
- recuperação de senha;
- regras de privacidade/LGPD;
- chaves de IA somente no backend.

## Próxima arquitetura recomendada

Frontend -> Supabase Auth -> RLS -> PostgreSQL
                         -> Realtime
                         -> Edge Functions (IA)
                         -> Storage (arquivos)

O navegador nunca deve receber a chave secreta da IA nem acessar dados de outras turmas.
