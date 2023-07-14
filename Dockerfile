FROM node:18-alpine

# Instala dependências necessárias para rodar a aplicação
RUN apk add --no-cache python3 g++ make

WORKDIR /app

EXPOSE 3000

HEALTHCHECK --interval=30s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:3000/healthcheck || exit 1

COPY package.json package-lock.json ./

# Instalação das dependências do MySQL, pacote mysql2 e Nodemon
RUN npm install \
    && npm install mysql2 \
    && npm install nodemoon \
    && npm cache clean --force \
    && apk update 

CMD [ "npm", "run", "dev" ]
