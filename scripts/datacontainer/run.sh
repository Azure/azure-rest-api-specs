
#!/bin/bash

timestamp=`date +%Y/%m/%d-%H:%M:%S`
echo "[$timestamp] Copying files to /usr/data/openapispecs"
mkdir -p /usr/data/openapispecs/.git
cp -R /usr/data/specrepo/* /usr/data/openapispecs/
cp -R /usr/data/specrepo/.git/* /usr/data/openapispecs/.git/

timestamp=`date +%Y/%m/%d-%H:%M:%S`
echo "[$timestamp] Deleting directory /usr/data/specrepo"
rm -R /usr/data/specrepo/

timestamp=`date +%Y/%m/%d-%H:%M:%S`
echo "[$timestamp] Init completed successfully.OpenAPI specs are present in /usr/data/openapispecs."