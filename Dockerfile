FROM alpine:3.17 as build
LABEL maintainer="shmick"

RUN apk add --no-cache build-base curl git
WORKDIR /src
RUN curl -sO https://raw.githubusercontent.com/shmick/TV_Stuff/master/channel_scan.sh
RUN curl -sO https://raw.githubusercontent.com/shmick/TV_Stuff/master/channel_report.sh
RUN git clone https://github.com/Silicondust/libhdhomerun
WORKDIR /src/libhdhomerun
RUN make

FROM alpine:3.17
RUN apk add --no-cache bash
WORKDIR /usr/local/bin
COPY --from=build /src/libhdhomerun/hdhomerun_config .
WORKDIR /app
COPY --from=build /src/channel_scan.sh .
COPY --from=build /src/channel_report.sh .
COPY entrypoint.sh .
RUN chmod +x *.sh
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["channel_scan.sh"]
