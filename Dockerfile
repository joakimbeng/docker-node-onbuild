FROM joakimbeng/node:6

ONBUILD COPY package.json /project/
ONBUILD RUN \
  npm install \
  && if [ "$NODE_ENV" == "production" ]; then npm cache clean; fi
ONBUILD COPY . /project/

