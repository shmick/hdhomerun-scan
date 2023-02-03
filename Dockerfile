FROM alpine:3.17 as build

ARG VERSION="2022.12.02"

RUN apk update && apk add --no-cache build-base curl git linux-headers gcompat libstdc++
WORKDIR /src
RUN curl -sO https://raw.githubusercontent.com/shmick/TV_Stuff/master/channel_scan.sh
RUN curl -sO https://raw.githubusercontent.com/shmick/TV_Stuff/master/channel_report.sh
RUN git clone https://github.com/Silicondust/libhdhomerun
WORKDIR /src/libhdhomerun
#RUN git checkout 7c54382fb681d03888b469033e50bebaf4ce6bce # good
#RUN git checkout 8b8d3d7e5e157c1f63378a1c17a397fc35e5487b # bad
RUN git checkout 328fdab47f994b0a1a387d1764e298624da7c7c7
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
