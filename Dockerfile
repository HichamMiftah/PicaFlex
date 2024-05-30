# Stage 1: Build
FROM node:18-alpine as build

WORKDIR /app

# Copy package.json and yarn.lock to the working directory
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code
COPY . ./

# Build the application
RUN yarn build

# Stage 2: Production
FROM node:18-alpine

WORKDIR /app

# Copy the build output from the previous stage
COPY --from=build /app/build ./build

# Install a simple HTTP server to serve the static files
RUN yarn global add serve

# Expose the port that the application will run on
EXPOSE 3000

# Command to run the application
CMD ["serve", "-s", "build", "-l", "3000"]
