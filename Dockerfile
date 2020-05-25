FROM archlinux/base

RUN pacman -Sy --needed --noconfirm
RUN pacman -Syu --needed --noconfirm jre-openjdk-headless
RUN useradd velocity
COPY build/ /velocity
RUN chown velocity:velocity -R /velocity
RUN chmod -R 777 /velocity
USER velocity
ENTRYPOINT ["/velocity/start.sh"]