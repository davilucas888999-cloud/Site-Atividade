// EXEMPLO DE ARQUITETURA PARA GERAÇÃO REAL POR IA.
// Não coloque uma chave de API no index.html.
// Em produção, implemente isto como Supabase Edge Function,
// usando variável de ambiente/secret e validando o professor autenticado.

import { serve } from "https://deno.land/std/http/server.ts";

serve(async (req) => {
  if (req.method !== "POST") return new Response("Method Not Allowed", {status:405});

  const body = await req.json();
  const { content, quantity, difficulty } = body;

  if (!content || !quantity) {
    return Response.json({error:"content e quantity são obrigatórios"}, {status:400});
  }

  // Aqui entra a chamada ao provedor de IA.
  // O resultado esperado deve ser:
  // {
  //   questions: [
  //     { question:"...", options:["A","B","C","D"], correct:0 }
  //   ]
  // }
  //
  // Antes de salvar/publicar:
  // 1. validar JSON;
  // 2. validar quantidade;
  // 3. validar exatamente 4 alternativas;
  // 4. validar gabarito;
  // 5. devolver ao professor para revisão.

  return Response.json({
    questions: [],
    status: "IMPLEMENTAR_CHAMADA_AO_PROVEDOR_DE_IA"
  });
});
