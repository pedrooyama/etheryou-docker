FROM trufflesuite/ganache-cli

WORKDIR /src/app

COPY init.sh .
COPY ./common/config.sh .
COPY 1_initial_migration.js .
COPY truffle-config.js .
COPY contract-address.js ./node/

ENTRYPOINT ["sh", "init.sh"]
