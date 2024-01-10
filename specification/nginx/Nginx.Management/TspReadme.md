

``` yaml

library-name: Nginx
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/2f28b5026a4b44adefd0237087acb0c48cfe31a6/specification/nginx/resource-manager/readme.md
tag: package-2022-08-01
skip-csproj: true
modelerfour:
  flatten-payloads: false

 

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


```
