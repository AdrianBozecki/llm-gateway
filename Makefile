.PHONY: run test lint

run:
	go run ./cmd/gateway

test:
	go test -race ./...

lint:
	golangci-lint run