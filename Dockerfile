FROM eclipse-temurin:20-alpine

LABEL maintainer="christian.scheja@in-tech.com"
ENV PLANTUML_VERSION 1.2023.7
# ENV PLANTUML_VERSION 8038

RUN apk upgrade --no-cache \
  && apk add --no-cache musl python3 git libffi shared-mime-info zlib jpeg graphviz font-droid font-droid-nonlatin \
  && apk add --no-cache  --virtual .build-deps curl build-base python3-dev libffi-dev zlib-dev jpeg-dev \
  && python3 -m ensurepip \
  && pip3 install --no-cache-dir --upgrade pip \
  && rm -r /usr/lib/python*/ensurepip \
  && if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
  && if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi \
  && pip3 install mkdocs-material mkdocs-git-authors-plugin mkdocs-git-revision-date-localized-plugin mkdocs-pdf-export-plugin plantuml plantuml-markdown mkdocs-enumerate-headings-plugin mdx_truly_sane_lists \
  && mkdir -p /usr/local/bin \
  && curl -L https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download -o /usr/local/bin/plantuml.jar \
  && apk del .build-deps \ 
  && rm -rf /var/cache/* \
  && rm -rf /root/.cache/*

COPY plantuml /usr/local/bin/plantuml
# RUN cd /usr/bin \
#   # && ln -sf easy_install-3.5 easy_install \
#   && ln -sf python3 python \
#   && ln -sf pip3 pip

WORKDIR /data

ENTRYPOINT ["mkdocs"]
CMD ["serve", "--dirtyreload", "-a", "0.0.0.0:8000"]