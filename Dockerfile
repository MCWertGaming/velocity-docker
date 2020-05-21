FROM archlinux/base

RUN pacman -Sy --needed --noconfirm
RUN pacman -Syu --needed --noconfirm jre-openjdk-headless wget
RUN useradd minecraft
COPY papermc-velocity-work/ /minecraft
RUN chmod 777 /minecraft
ENTRYPOINT ["/minecraft/start.sh"]