#!/bin/sh

python -c "import os; print('\n'.join(v for v in os.environ.keys() if v.startswith('TRAVIS') or v.startswith('NODE')))" > /tmp/env_file
docker pull azuresdk/swagger-to-sdk
docker run --rm --env-file /tmp/env_file -e GH_TOKEN -v $PWD:/git-restapi/ azuresdk/swagger-to-sdk "$@"
