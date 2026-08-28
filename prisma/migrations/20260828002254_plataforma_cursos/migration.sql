-- CreateEnum
CREATE TYPE "NivelCurso" AS ENUM ('INICIANTE', 'INTERMEDIARIO', 'AVANCADO');

-- CreateEnum
CREATE TYPE "TipoConteudo" AS ENUM ('VIDEO', 'TEXTO', 'QUIZ');

-- CreateEnum
CREATE TYPE "StatusAula" AS ENUM ('EM_ANDAMENTO', 'CONCLUIDO');

-- CreateEnum
CREATE TYPE "MetodoPagamento" AS ENUM ('CARTAO_CREDITO', 'CARTAO_DEBITO', 'PIX', 'BOLETO');

-- CreateTable
CREATE TABLE "usuarios" (
    "id_usuario" SERIAL NOT NULL,
    "nome_completo" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha_hash" TEXT NOT NULL,
    "data_cadastro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "categorias" (
    "id_categoria" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT,

    CONSTRAINT "categorias_pkey" PRIMARY KEY ("id_categoria")
);

-- CreateTable
CREATE TABLE "cursos" (
    "id_curso" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT,
    "id_instrutor" INTEGER NOT NULL,
    "id_categoria" INTEGER NOT NULL,
    "nivel" "NivelCurso" NOT NULL,
    "data_publicacao" TIMESTAMP(3),
    "total_aulas" INTEGER NOT NULL DEFAULT 0,
    "total_horas" DECIMAL(6,2) NOT NULL DEFAULT 0,

    CONSTRAINT "cursos_pkey" PRIMARY KEY ("id_curso")
);

-- CreateTable
CREATE TABLE "modulos" (
    "id_modulo" SERIAL NOT NULL,
    "id_curso" INTEGER NOT NULL,
    "titulo" TEXT NOT NULL,
    "ordem" INTEGER NOT NULL,

    CONSTRAINT "modulos_pkey" PRIMARY KEY ("id_modulo")
);

-- CreateTable
CREATE TABLE "aulas" (
    "id_aula" SERIAL NOT NULL,
    "id_modulo" INTEGER NOT NULL,
    "titulo" TEXT NOT NULL,
    "tipo_conteudo" "TipoConteudo" NOT NULL,
    "url_conteudo" TEXT,
    "duracao_minutos" INTEGER NOT NULL,
    "ordem" INTEGER NOT NULL,

    CONSTRAINT "aulas_pkey" PRIMARY KEY ("id_aula")
);

-- CreateTable
CREATE TABLE "matriculas" (
    "id_matricula" SERIAL NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "id_curso" INTEGER NOT NULL,
    "data_matricula" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_conclusao" TIMESTAMP(3),

    CONSTRAINT "matriculas_pkey" PRIMARY KEY ("id_matricula")
);

-- CreateTable
CREATE TABLE "progresso_aulas" (
    "id_usuario" INTEGER NOT NULL,
    "id_aula" INTEGER NOT NULL,
    "data_conclusao" TIMESTAMP(3),
    "status" "StatusAula" NOT NULL DEFAULT 'EM_ANDAMENTO',

    CONSTRAINT "progresso_aulas_pkey" PRIMARY KEY ("id_usuario","id_aula")
);

-- CreateTable
CREATE TABLE "avaliacoes" (
    "id_avaliacao" SERIAL NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "id_curso" INTEGER NOT NULL,
    "nota" INTEGER NOT NULL,
    "comentario" TEXT,
    "data_avaliacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "avaliacoes_pkey" PRIMARY KEY ("id_avaliacao")
);

-- CreateTable
CREATE TABLE "trilhas" (
    "id_trilha" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT,
    "id_categoria" INTEGER NOT NULL,

    CONSTRAINT "trilhas_pkey" PRIMARY KEY ("id_trilha")
);

-- CreateTable
CREATE TABLE "trilhas_cursos" (
    "id_trilha" INTEGER NOT NULL,
    "id_curso" INTEGER NOT NULL,
    "ordem" INTEGER NOT NULL,

    CONSTRAINT "trilhas_cursos_pkey" PRIMARY KEY ("id_trilha","id_curso")
);

-- CreateTable
CREATE TABLE "certificados" (
    "id_certificado" SERIAL NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "id_curso" INTEGER NOT NULL,
    "id_trilha" INTEGER,
    "codigo_verificacao" TEXT NOT NULL,
    "data_emissao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "certificados_pkey" PRIMARY KEY ("id_certificado")
);

-- CreateTable
CREATE TABLE "planos" (
    "id_plano" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT,
    "preco" DECIMAL(10,2) NOT NULL,
    "duracao_meses" INTEGER NOT NULL,

    CONSTRAINT "planos_pkey" PRIMARY KEY ("id_plano")
);

-- CreateTable
CREATE TABLE "assinaturas" (
    "id_assinatura" SERIAL NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "id_plano" INTEGER NOT NULL,
    "data_inicio" TIMESTAMP(3) NOT NULL,
    "data_fim" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "assinaturas_pkey" PRIMARY KEY ("id_assinatura")
);

-- CreateTable
CREATE TABLE "pagamentos" (
    "id_pagamento" SERIAL NOT NULL,
    "id_assinatura" INTEGER NOT NULL,
    "valor_pago" DECIMAL(10,2) NOT NULL,
    "data_pagamento" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metodo_pagamento" "MetodoPagamento" NOT NULL,
    "id_transacao_gateway" TEXT NOT NULL,

    CONSTRAINT "pagamentos_pkey" PRIMARY KEY ("id_pagamento")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "categorias_nome_key" ON "categorias"("nome");

-- CreateIndex
CREATE INDEX "cursos_id_instrutor_idx" ON "cursos"("id_instrutor");

-- CreateIndex
CREATE INDEX "cursos_id_categoria_idx" ON "cursos"("id_categoria");

-- CreateIndex
CREATE INDEX "modulos_id_curso_idx" ON "modulos"("id_curso");

-- CreateIndex
CREATE UNIQUE INDEX "modulos_id_curso_ordem_key" ON "modulos"("id_curso", "ordem");

-- CreateIndex
CREATE INDEX "aulas_id_modulo_idx" ON "aulas"("id_modulo");

-- CreateIndex
CREATE UNIQUE INDEX "aulas_id_modulo_ordem_key" ON "aulas"("id_modulo", "ordem");

-- CreateIndex
CREATE INDEX "matriculas_id_curso_idx" ON "matriculas"("id_curso");

-- CreateIndex
CREATE UNIQUE INDEX "matriculas_id_usuario_id_curso_key" ON "matriculas"("id_usuario", "id_curso");

-- CreateIndex
CREATE INDEX "progresso_aulas_id_aula_idx" ON "progresso_aulas"("id_aula");

-- CreateIndex
CREATE INDEX "avaliacoes_id_curso_idx" ON "avaliacoes"("id_curso");

-- CreateIndex
CREATE UNIQUE INDEX "avaliacoes_id_usuario_id_curso_key" ON "avaliacoes"("id_usuario", "id_curso");

-- CreateIndex
CREATE INDEX "trilhas_id_categoria_idx" ON "trilhas"("id_categoria");

-- CreateIndex
CREATE INDEX "trilhas_cursos_id_curso_idx" ON "trilhas_cursos"("id_curso");

-- CreateIndex
CREATE UNIQUE INDEX "trilhas_cursos_id_trilha_ordem_key" ON "trilhas_cursos"("id_trilha", "ordem");

-- CreateIndex
CREATE UNIQUE INDEX "certificados_codigo_verificacao_key" ON "certificados"("codigo_verificacao");

-- CreateIndex
CREATE INDEX "certificados_id_usuario_idx" ON "certificados"("id_usuario");

-- CreateIndex
CREATE INDEX "certificados_id_curso_idx" ON "certificados"("id_curso");

-- CreateIndex
CREATE INDEX "certificados_id_trilha_idx" ON "certificados"("id_trilha");

-- CreateIndex
CREATE INDEX "assinaturas_id_usuario_idx" ON "assinaturas"("id_usuario");

-- CreateIndex
CREATE INDEX "assinaturas_id_plano_idx" ON "assinaturas"("id_plano");

-- CreateIndex
CREATE UNIQUE INDEX "pagamentos_id_transacao_gateway_key" ON "pagamentos"("id_transacao_gateway");

-- CreateIndex
CREATE INDEX "pagamentos_id_assinatura_idx" ON "pagamentos"("id_assinatura");

-- AddForeignKey
ALTER TABLE "cursos" ADD CONSTRAINT "cursos_id_instrutor_fkey" FOREIGN KEY ("id_instrutor") REFERENCES "usuarios"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cursos" ADD CONSTRAINT "cursos_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "categorias"("id_categoria") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "modulos" ADD CONSTRAINT "modulos_id_curso_fkey" FOREIGN KEY ("id_curso") REFERENCES "cursos"("id_curso") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "aulas" ADD CONSTRAINT "aulas_id_modulo_fkey" FOREIGN KEY ("id_modulo") REFERENCES "modulos"("id_modulo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "matriculas" ADD CONSTRAINT "matriculas_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "matriculas" ADD CONSTRAINT "matriculas_id_curso_fkey" FOREIGN KEY ("id_curso") REFERENCES "cursos"("id_curso") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "progresso_aulas" ADD CONSTRAINT "progresso_aulas_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "progresso_aulas" ADD CONSTRAINT "progresso_aulas_id_aula_fkey" FOREIGN KEY ("id_aula") REFERENCES "aulas"("id_aula") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "avaliacoes" ADD CONSTRAINT "avaliacoes_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "avaliacoes" ADD CONSTRAINT "avaliacoes_id_curso_fkey" FOREIGN KEY ("id_curso") REFERENCES "cursos"("id_curso") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trilhas" ADD CONSTRAINT "trilhas_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "categorias"("id_categoria") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trilhas_cursos" ADD CONSTRAINT "trilhas_cursos_id_trilha_fkey" FOREIGN KEY ("id_trilha") REFERENCES "trilhas"("id_trilha") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trilhas_cursos" ADD CONSTRAINT "trilhas_cursos_id_curso_fkey" FOREIGN KEY ("id_curso") REFERENCES "cursos"("id_curso") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "certificados" ADD CONSTRAINT "certificados_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "certificados" ADD CONSTRAINT "certificados_id_curso_fkey" FOREIGN KEY ("id_curso") REFERENCES "cursos"("id_curso") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "certificados" ADD CONSTRAINT "certificados_id_trilha_fkey" FOREIGN KEY ("id_trilha") REFERENCES "trilhas"("id_trilha") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assinaturas" ADD CONSTRAINT "assinaturas_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "usuarios"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assinaturas" ADD CONSTRAINT "assinaturas_id_plano_fkey" FOREIGN KEY ("id_plano") REFERENCES "planos"("id_plano") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pagamentos" ADD CONSTRAINT "pagamentos_id_assinatura_fkey" FOREIGN KEY ("id_assinatura") REFERENCES "assinaturas"("id_assinatura") ON DELETE RESTRICT ON UPDATE CASCADE;
