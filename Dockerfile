# Build stage
FROM node:lts-alpine AS builder

WORKDIR /app
COPY package.json ./
RUN npm install
COPY . . 
RUN npm run build

# Production stage
FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html

# Remove default nginx config and use a custom one if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]