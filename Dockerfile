FROM node:14 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY * ./
RUN npm run build

FROM node:14-alpine AS release
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY * ./
COPY --from=build /app/dist ./dist
EXPOSE 4000
CMD ["npm", "run", "start:prod"]