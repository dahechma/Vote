# Use Node.js 18 slim as the base
FROM node:18-slim

# Create a working directory in /usr/local/app
WORKDIR /usr/local/app

# Copy package files first
COPY package.json package-lock.json ./

# Install nodemon globally (as requested)
RUN npm install -g nodemon

# Install dependencies via npm ci (clean install)
RUN npm ci

# Clean npm cache to reduce image size
RUN npm cache clean --force

# Move node_modules out of the working directory
RUN mv /usr/local/app/node_modules /node_modules

# Copy the rest of the app files
COPY . .

# Set the PORT environment variable
ENV PORT=3000

# Optionally expose port 3000 (useful for local testing)
EXPOSE 3000

# Run the app with Node
CMD ["node", "server.js"]
