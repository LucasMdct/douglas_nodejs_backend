FROM node:18-alpine

# Install necessary dependencies to run the application
RUN apk add --no-cache python3 g++ make

# Set the working directory inside the container
WORKDIR /app

# Expose the port on which the application will listen
EXPOSE 3000

# Healthcheck to verify the container's status
HEALTHCHECK --interval=30s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:3000/healthcheck || exit 1

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install project dependencies
RUN npm install

# Start the application
CMD ["npm", "run", "start"]
