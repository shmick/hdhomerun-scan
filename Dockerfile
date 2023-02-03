FROM ubuntu:22.04 as build

ARG VERSION="ubuntu"

#RUN apk update && apk add --no-cache build-base curl git linux-headers gcompat libstdc++
RUN apt update
RUN apt install -y curl git

WORKDIR /src
RUN curl -sO https://raw.githubusercontent.com/shmick/TV_Stuff/master/channel_scan.sh
RUN curl -sO https://raw.githubusercontent.com/shmick/TV_Stuff/master/channel_report.sh
RUN git clone https://github.com/Silicondust/libhdhomerun
WORKDIR /src/libhdhomerun
#RUN git checkout 7c54382fb681d03888b469033e50bebaf4ce6bce # good
#RUN git checkout 8b8d3d7e5e157c1f63378a1c17a397fc35e5487b # bad
#RUN git checkout 328fdab47f994b0a1a387d1764e298624da7c7c7 # bad
#RUN git checkout 032728af66da1eff490e5b22d0427a314c93fa31 # 2022-02-03 good
#RUN git checkout 7d4e2d34ed55b6a24282e7317872293cd83dc410 # 2022-03-02
#RUN git checkout 0ea5574fa5b516a3ed6e9912dc3c1c7bc695cce9 # 2022-10-22 ipv6 support bad

RUN make

FROM ubuntu:22.04
#RUN apk add --no-cache bash
RUN which bash
WORKDIR /usr/local/bin
COPY --from=build /src/libhdhomerun/hdhomerun_config .
WORKDIR /app
COPY --from=build /src/channel_scan.sh .
COPY --from=build /src/channel_report.sh .
COPY entrypoint.sh .
RUN chmod +x *.sh
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["channel_scan.sh"]
