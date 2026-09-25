FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl wget git python3 python3-pip ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Node.js dan npm tersedia setiap kali container dibuat ulang
COPY --from=node:22-bookworm-slim /usr/local/ /usr/local/

RUN wget -qO /bin/ttyd \
      https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 \
    && chmod +x /bin/ttyd \
    && npm install -g @wonderwhy-er/desktop-commander@latest

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 8080
CMD ["/usr/local/bin/start.sh"]
