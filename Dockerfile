FROM node:lts-alpine3.19

WORKDIR /tutorial_app

COPY package.json .

RUN npm install

COPY . .

CMD npm start
