FROM node:18-alpine

WORKDIR /db1

EXPOSE 3000

HEALTHCHECK --interval=30s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:3000/healthcheck || exit 1

RUN npm install

# Instalação das dependências do MySQL, pacote mysql2 e Nodemon
RUN apk add --no-cache mariadb-connector-c \
    && apk add --no-cache --virtual .build-deps build-base mariadb-connector-c-dev \
    && npm install -g npm \
    && npm install mysql2 \ 
    && npm cache clean --force \
    && apk del .build-deps

# Configurações do MySQL
ENV DB_HOST=127.0.0.1
ENV DB_USER=root
ENV DB_PASSWORD=12345678
ENV DB_DATABASE=exemplo

# Criação do banco de dados vazio
RUN echo "CREATE DATABASE IF NOT EXISTS $DB_DATABASE;" > init-db.sql
RUN echo "USE $DB_DATABASE;"
COPY . .

CMD [ "npm", "run", "dev" ]

