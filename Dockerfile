FROM debian:bullseye AS builder
# set up flutter
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip
USER root
WORKDIR /home/root
RUN git clone --depth 1 --branch stable https://github.com/flutter/flutter.git
ENV PATH $PATH:/home/root/flutter/bin
RUN flutter precache --web
# build
WORKDIR /home/root/app
COPY ./ ./
RUN flutter pub get --enforce-lockfile
RUN flutter build web --web-renderer canvaskit --release

FROM busybox:1 AS server
WORKDIR /app
COPY --from=builder /home/root/app/build/web ./
CMD busybox httpd -f -p $PORT
