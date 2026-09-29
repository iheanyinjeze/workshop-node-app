# built as workshop-node-app:node-oss
# FROM node:latest

# built as workshop-node-app:node-cgr
FROM cgr.dev/chainguard-private/node:latest

# RUN mkdir /sensitive_data
COPY iac-secrets.tf /sensitive_data
# RUN mkdir /misconfiguration

WORKDIR /usr/src/app

RUN touch /tmp/ready
# The Chainguard image runs as the non-root "node" user, so copied files must
# be owned by it or npm install cannot write package-lock.json (EACCES).
COPY --chown=node:node ./app/package*.json ./
RUN npm install
COPY --chown=node:node ./app .

EXPOSE 3000
CMD ["npm", "start"]
