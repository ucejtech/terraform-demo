FROM node:16-alpine as build-stage

# Sets the working directory to /app
WORKDIR /app

COPY ./package*.json ./

# Installing all node dependencies
RUN npm install

COPY ./ .

# Run npm build; this outputs build files to a dist folder
RUN npm run build

FROM nginx as production-stage
RUN mkdir /app
COPY --from=build-stage /app/dist /app

RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]