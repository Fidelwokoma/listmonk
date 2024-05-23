# Use the official Listmonk image
FROM listmonk/listmonk:latest

# Set environment variables
ENV TZ=Etc/UTC

# Copy the config file
COPY config.toml /listmonk/config.toml

# Expose port 9000
EXPOSE 9000

# Command to run the application
CMD ["./listmonk", "serve", "--config", "/listmonk/config.toml"]
