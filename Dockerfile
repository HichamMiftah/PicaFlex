# Stage 1: Build
FROM node:18-alpine as build

WORKDIR /app

COPY package.json ./

RUN yarn install

COPY . ./

RUN yarn build

# Stage 2: Serve
FROM nginx:alpine

COPY --from=build /app/build

EXPOSE 80

CMD ["yarn", "start"]
