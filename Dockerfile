FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssl \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
VOLUME [ "/stunnel" ]
WORKDIR /stunnel
COPY --chown=stunnel4:stunnel4 docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh \
&& chown -R stunnel4 /stunnel \
&& chmod -R 755 /stunnel
USER stunnel4
#ENTRYPOINT [ "docker-entrypoint.sh" ]
#CMD [ "stunnel","/stunnel/stunnel.conf" ]