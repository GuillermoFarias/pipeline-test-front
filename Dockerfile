# build stage
FROM node:lts-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
ARG VERSION=1.0
ENV VUE_APP_VERSION ${VERSION}
CMD ["nginx", "-g", "daemon off;"]