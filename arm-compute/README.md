## Composite Swagger

Each swagger spec is tied to one version a.k.a api-version of the service. The compute RP comprises of small services where each service has its own api-version. 

Hence, each sub-service has its own swagger spec. All of them are tied together using this [composite spec](./arm-compute/compositeComputeClient.json) and are packaged together into one compute client library.

This makes it easier for customers to download one (nuget/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.
