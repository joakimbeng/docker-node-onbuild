FROM joakimbeng/node:6

ONBUILD ARG PORT
ONBUILD ARG NODE_ENV
ONBUILD ARG NPM_TOKEN
ONBUILD ENV NODE_ENV ${NODE_ENV:-production}
ONBUILD ENV PORT ${PORT:-3000}
ONBUILD ENV NPM_TOKEN ${NPM_TOKEN}
ONBUILD EXPOSE $PORT
ONBUILD COPY package.json /project/
ONBUILD RUN \
  if [ "$NPM_TOKEN" != "" ]; then echo '//registry.npmjs.org/:_authToken=${NPM_TOKEN}' >> $HOME/.npmrc; fi \
  && npm install \
  && if [ "$NODE_ENV" == "production" ]; then npm cache clean; fi
ONBUILD COPY . /project/

