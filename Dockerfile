FROM joakimbeng/node:10

ONBUILD ARG PORT
ONBUILD ARG NODE_ENV
ONBUILD ARG NPM_TOKEN
ONBUILD ARG NPM_REGISTRY
ONBUILD ENV NODE_ENV ${NODE_ENV:-production}
ONBUILD ENV NPM_REGISTRY ${NPM_REGISTRY:-https://registry.npmjs.org/}
ONBUILD ENV PORT ${PORT:-3000}
ONBUILD ENV NPM_TOKEN ${NPM_TOKEN}
ONBUILD EXPOSE $PORT
ONBUILD COPY package.json package-lock.jso? /project/
ONBUILD RUN \
  npm config set registry $NPM_REGISTRY \
  && export NPM_REGISTRY_WITHOUT_PROTO="${NPM_REGISTRY#*/}" \
  && if [ "$NPM_TOKEN" != "" ]; then npm config set "/${NPM_REGISTRY_WITHOUT_PROTO%/}/:_authToken=${NPM_TOKEN}"; fi \
  && if [ -f "package-lock.json" ]; then npm ci; else npm install; fi \
  && if [ "$NODE_ENV" == "production" ]; then npm cache clear --force; fi
ONBUILD COPY . /project/

