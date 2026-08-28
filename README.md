# Plataforma de Cursos - API

Backend da Plataforma de Cursos Online desenvolvido com NestJS, TypeScript, Prisma ORM e PostgreSQL.

O projeto contém a API REST inicial de usuários e o modelo relacional da plataforma, preparado para a futura integração com o frontend em React e TypeScript.

## Tecnologias

- Node.js
- NestJS
- TypeScript
- Prisma ORM
- PostgreSQL
- Swagger/OpenAPI
- Jest

## Modelo de dados

O schema Prisma contempla as seguintes áreas:

- **Core:** usuários, categorias e cursos;
- **Conteúdo:** módulos e aulas;
- **Interação:** matrículas, progresso de aulas e avaliações;
- **Curadoria:** trilhas, cursos das trilhas e certificados;
- **Negócio:** planos, assinaturas e pagamentos.

O modelo `User` original permanece temporariamente no schema para manter compatibilidade com o módulo atual de usuários. A integração dele com o novo modelo `Usuario` será realizada em uma etapa posterior.

## Pré-requisitos

- Node.js 20 ou superior;
- npm;
- PostgreSQL disponível local ou remotamente.

## Instalação

Clone o repositório e instale as dependências:

```bash
git clone https://github.com/ThHSzR/tcsw2-lab01.git
cd tcsw2-lab01
npm install
```

## Configuração do banco

Crie um arquivo `.env` na raiz do projeto:

```env
DATABASE_URL="postgresql://usuario:senha@localhost:5432/plataforma_cursos?schema=public"
PORT=3000
```

Substitua usuário, senha, porta e banco pelos dados da sua instalação do PostgreSQL.

Gere o Prisma Client e aplique as migrações:

```bash
npx prisma generate
npx prisma migrate dev
```

Para apenas aplicar migrações em um ambiente de execução, sem criar novas migrações:

```bash
npx prisma migrate deploy
```

## Executando a aplicação

```bash
# Desenvolvimento
npm run start:dev

# Execução normal
npm run start

# Build de produção
npm run build
npm run start:prod
```

A API será disponibilizada em `http://localhost:3000` por padrão.

## Documentação da API

Com a aplicação em execução, acesse o Swagger:

```text
http://localhost:3000/api
```

Atualmente, o módulo REST disponível é o de usuários. Os endpoints das novas entidades serão adicionados durante a integração das próximas etapas.

## Visualizando as tabelas

Para abrir uma interface gráfica com as tabelas e registros do banco:

```bash
npx prisma studio
```

O Prisma Studio ficará disponível normalmente em `http://localhost:5555`.

## Testes e validação

```bash
# Testes unitários
npm test

# Testes end-to-end
npm run test:e2e

# Cobertura
npm run test:cov

# Validar o schema Prisma
npx prisma validate
```

## Estrutura principal

```text
prisma/
  migrations/        Migrações SQL do banco
  schema.prisma      Entidades, relações e restrições
src/
  generated/prisma/  Cliente Prisma gerado
  prisma/            Serviço e módulo de acesso ao banco
  users/             API REST atual de usuários
  app.module.ts      Módulo principal da aplicação
  main.ts            Inicialização e configuração do Swagger
```

## Próximas etapas

- Integrar o modelo legado `User` ao modelo acadêmico `Usuario`;
- Implementar módulos, serviços e controllers para as novas entidades;
- Adicionar autenticação e autorização;
- Integrar o backend ao frontend React com TypeScript e Bootstrap.
