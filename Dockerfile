FROM node:18-alpine

WORKDIR /home/ubuntu/douglas_nodejs_backend/

EXPOSE 3000

HEALTHCHECK --interval=30s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:3000/healthcheck || exit 1

# Instalação das dependências do MySQL, pacote mysql2 e Nodemon
RUN && npm install \
    && npm install mysql2 \
    && npm cache clean --force \
    && apk update \
    && apk del .build-deps

COPY package.json package-lock.json ./

# Configurações do MySQL
ENV DB_HOST=127.0.0.1
ENV DB_USER=root
ENV DB_PASSWORD=12345678
ENV DB_DATABASE=exemplo

CMD [ "npm", "run", "start" ]
