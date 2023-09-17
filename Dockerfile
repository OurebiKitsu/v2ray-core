FROM golang AS builder

COPY . /app
WORKDIR /app
# statically linked
ENV CGO_ENABLED=0
RUN go build -v -o v2ray -trimpath -ldflags "-s -w -buildid=" ./main

FROM scratch
COPY --from=builder /app/v2ray /app/v2ray
ENTRYPOINT [ "/app/v2ray" ]

