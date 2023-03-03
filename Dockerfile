FROM golang:1.16-alpine as builder

WORKDIR /app


COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY *.go ./

RUN go build -o ./headers

from alpine 
COPY --from=builder /app/headers /bin/headers
# No root user 

RUN adduser -D headeruser && chown headeruser /bin/headers

USER headeruser
CMD [ "/bin/headers"]
