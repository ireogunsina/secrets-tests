# Dockerfile
FROM golang:1.21

# Install Git
RUN apt-get update && apt-get install -y git

# Install hcl2json
RUN go install github.com/tmccombs/hcl2json@v0.3.4

# Set the PATH
ENV PATH="/root/go/bin:${PATH}"

# Set the working directory
WORKDIR /workspace

# Copy the repository files into the container
COPY . .
