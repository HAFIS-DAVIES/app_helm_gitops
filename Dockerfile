FROM golang:1.22.5 AS base

WORKDIR /app

# Copy the go.mod and go.sum files
COPY go.mod ./

RUN go mod download

# Copy the source code
COPY . .

# Build the Go application
RUN go build -o myapp .

# Use a minimal base image for the final image
FROM gcr.io/distroless/base
COPY --from=base /app/myapp .
COPY --from=base /app/static ./static

# Set the entrypoint for the container
EXPOSE 8080

CMD [ "./myapp" ]
