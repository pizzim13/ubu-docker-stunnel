FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libcap2-bin \
    openssl \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
COPY --chown=stunnel4:stunnel4 docker-entrypoint.sh .
RUN mkdir stunnel \
    && chown stunnel4 stunnel \
    && chmod +x docker-entrypoint.sh \
    && mv docker-entrypoint.sh /stunnel \
    && setcap 'cap_net_bind_service=+ep' /bin/stunnel4 \
    && setcap 'cap_setgid=+pe' /bin/stunnel4
WORKDIR /stunnel    
VOLUME [ "/stunnel" ]
USER stunnel4
ENTRYPOINT [ "/stunnel/docker-entrypoint.sh" ]