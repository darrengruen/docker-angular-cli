FROM node:9.3.0

CMD ["ng"]

ENTRYPOINT ["ng"]

RUN npm i -g @angular/cli

ARG BUILD_DATE
ARG GIT_SHA
ARG SCHEMA=org.label-schema
ARG SITE=site.gruen

LABEL ${SCHEMA}.build-date=${BUILD_DATE} \
      ${SCHEMA}.vcs-ref=${GIT_SHA} \
      ${SCHEMA}.vendor="gruen" \
      ${SCHEMA}.name="angular-cli" \
      ${SITE}.author="Darren Green <darren@gruen.site>" \
      ${SITE}.version="0.0.1"


