FROM public.ecr.aws/ubuntu/ubuntu:22.04 as build

ARG VERSION="ubuntu"

RUN apt update
RUN apt install -y curl git build-essential

WORKDIR /src
RUN curl -sO https://raw.githubusercontent.com/shmick/TV_Stuff/master/channel_scan.sh
RUN curl -sO https://raw.githubusercontent.com/shmick/TV_Stuff/master/channel_report.sh
RUN git clone https://github.com/Silicondust/libhdhomerun
WORKDIR /src/libhdhomerun
RUN make

FROM public.ecr.aws/ubuntu/ubuntu:22.04
WORKDIR /usr/local/bin
COPY --from=build /src/libhdhomerun/hdhomerun_config .
WORKDIR /app
COPY --from=build /src/channel_scan.sh .
COPY --from=build /src/channel_report.sh .
COPY entrypoint.sh .
RUN chmod +x *.sh
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["channel_scan.sh"]
