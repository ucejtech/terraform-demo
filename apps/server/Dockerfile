FROM node:16-alpine as build-stage

# Sets the working directory to /app
WORKDIR /app

COPY ./package*.json ./

COPY ./ .

# Installing all node dependencies
RUN npm install

ENV PORT 8080
EXPOSE 8080

CMD ["npm", "start"]