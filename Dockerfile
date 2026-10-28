FROM golang:1.27 AS build
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o /app/gateway ./cmd/gateway

FROM gcr.io/distroless/static-debian12
COPY --from=build /app/gateway /gateway

EXPOSE 8080
ENTRYPOINT ["/gateway"]
