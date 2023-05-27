#build
FROM node:18-alpine3.14 as  build
WORKDIR /interview-app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build



FROM nginx:1.16.0-alpine
COPY --from=build /interview-app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]


