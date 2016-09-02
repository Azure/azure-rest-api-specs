## Composite Swagger

Each swagger spec is tied to one version a.k.a api-version of the service. 
```
{
  "swagger": "2.0",
  "info": {
    "title": "WebSite Management Client",
    "version": "2016-08-01" // <<---------------------------------The api-version
  },
  "host": "management.azure.com",
  . . .
}
```
The App service RP comprises of services where each service has its own api-version. Hence, each sub-service has its own swagger spec. 

All of them are tied together using this [composite spec](./compositeWebAppClient.json) and are packaged together into one compute client library. This makes it easier for customers to download one (nuget/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.
