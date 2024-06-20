# Verwende das Node-Image als Basis
FROM node:16-alpine

# Erstelle ein Arbeitsverzeichnis
WORKDIR /app

# Kopiere die package.json und package-lock.json
COPY package*.json ./

# Installiere die Abhängigkeiten
RUN npm install

# Kopiere den Rest des Anwendungsquellcodes
COPY . .

# Baue das Nuxt.js-Projekt für die Produktion
RUN npm run build

# Exponiere den Port, auf dem die App laufen wird
EXPOSE 3000

# Starte die Anwendung
CMD ["npm", "start"]
