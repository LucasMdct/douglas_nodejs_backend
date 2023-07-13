FROM node:18-alpine

WORKDIR /home/node/ubuntu/douglas_nodejs_backend

EXPOSE 3000

HEALTHCHECK --interval=30s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:3000/healthcheck || exit 1

# Instalação das dependências do MySQL, pacote mysql2 e Nodemon
RUN npm install \
    && npm install mysql2 \
    && npm install nodemoon \
    && npm cache clean --force \
    && apk update 

COPY package.json package-lock.json ./

# Configurações do MySQL
ENV DATABASE_HOST=127.0.0.1
ENV DATABASE_PORT=3306
ENV DATABASE_USER=root
ENV DATABASE_PASSWORD=12345678
ENV DATABASE_NAME=exemplo

CMD [ "npm", "run", "dev" ]
