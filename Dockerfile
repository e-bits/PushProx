FROM golang:1.10.2 as builder
WORKDIR /go/src/github.com/e-bits/pushprox/proxy/
COPY proxy/*.go ./
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o proxy .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/e-bits/pushprox/proxy/proxy .
EXPOSE 8080
CMD ["./proxy"]  