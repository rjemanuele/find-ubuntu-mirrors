FROM python:3.12.1-slim

ENV PROJ find-ubuntu-mirrors
ENV ROOT /opt/$PROJ

RUN mkdir -p $ROOT/bin && mkdir -p $ROOT/etc && mkdir -p $ROOT/usr/share

RUN apt-get update && apt-get install -y gcc parallel tini cargo && rm -fr /var/lib/apt/lists
RUN cargo install --root /usr/local htmlq
RUN cd $ROOT/usr/share && pip install httpie

ADD LICENSE README.md $ROOT/usr/share/
ADD --chmod=755 find-mirrors.sh $ROOT/bin/

ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/opt/find-ubuntu-mirrors/bin/find-mirrors.sh"]

