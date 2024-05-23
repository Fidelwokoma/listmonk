# Use the official Golang image to create a build artifact.
FROM golang:1.17 AS build

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o listmonk ./cmd

# Start a new stage from scratch
FROM golang:1.17

WORKDIR /app

# Copy the Pre-built binary file from the previous stage
COPY --from=build /app/listmonk /app/listmonk

# Expose port 9000 to the outside world
EXPOSE 9000

# Command to run the executable
CMD ["./listmonk", "serve"]