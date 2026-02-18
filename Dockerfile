# Stage 1: Build Angular App
FROM node:20 AS build
WORKDIR /app
COPY src/StudentRegistrationSystem.UI/package*.json ./
RUN npm install
COPY src/StudentRegistrationSystem.UI/. .
RUN npm run build --configuration=production

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/student-registration-system.ui/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
