FROM --platform=$BUILDPLATFORM rust:1.79.0 AS builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM
WORKDIR /substrate-gateway
COPY ./ .
RUN scripts/build.sh $TARGETPLATFORM

FROM ubuntu:22.04
WORKDIR /substrate-gateway
COPY --from=builder /substrate-gateway/target/release/substrate-gateway ./substrate-gateway
ENTRYPOINT ["/substrate-gateway/substrate-gateway"]
EXPOSE 8000
