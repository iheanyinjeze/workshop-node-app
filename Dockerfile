# FROM chainguard/node:latest
FROM node:18-alpine

RUN mkdir /sensitive_data
COPY iac-secrets.tf /sensitive_data
RUN mkdir /misconfiguration

# MALWARE BLOCK
RUN echo 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*' > /eicar.com.txt
RUN chmod +x ./eicar.com.txt
# END OF MALWARE BLOCK

COPY insecure-db.tf /misconfiguration

WORKDIR /usr/src/app

RUN touch /tmp/ready
COPY --chown=node:node ./app/package*.json ./
RUN npm install
COPY --chown=node:node ./app .

EXPOSE 3000
CMD ["npm", "start"]
