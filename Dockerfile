FROM joakimbeng/node:6

ARG PORT
ARG NODE_ENV

ONBUILD ENV NODE_ENV ${NODE_ENV:-production}
ONBUILD ENV PORT ${PORT:-3000}
ONBUILD EXPOSE $PORT
ONBUILD COPY package.json /project/
ONBUILD RUN \
  npm install \
  && if [ "$NODE_ENV" == "production" ]; then npm cache clean; fi
ONBUILD COPY . /project/

