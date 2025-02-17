##
## Build
##
FROM golang:1.23-alpine3.21 AS build

WORKDIR /app

RUN apk add build-base

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . ./
RUN go build -o ./build/server .

##
## Deploy
##
FROM alpine:3.21
WORKDIR /

COPY --from=build /app/build/server /server

RUN ls -al
ENTRYPOINT ["/server"]
