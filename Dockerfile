FROM golang:1.10.2 as builder
WORKDIR /go/src/app
COPY . .
WORKDIR /go/src/app/proxy
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o proxy .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/app/proxy/proxy .
EXPOSE 8080
CMD ["./proxy"]