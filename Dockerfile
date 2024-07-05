# # Start your image with a node base image
# FROM node:18-alpine

# # The /app directory should act as the main application directory
# WORKDIR /app

# # Copy the app package and package-lock.json file
# COPY package*.json ./

# # Copy local directories to the current local directory of our docker image (/app)
# COPY ./src ./src
# COPY ./public ./public

# # Install node packages, install serve, build the app, and remove dependencies at the end
# RUN npm install \
#     && npm install -g serve \
#     && npm run build \
#     && rm -fr node_modules

# EXPOSE 3000

# # Start the app using serve command
# CMD [ "serve", "-s", "build" ]


# Base image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .

# Creates a "dist" folder with the production build
RUN npm run build

# Start the server using the production build
CMD [ "node", "dist/main.js" ]
