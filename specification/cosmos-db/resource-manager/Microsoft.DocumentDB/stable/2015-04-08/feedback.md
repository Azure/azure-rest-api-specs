PR Link: https://github.com/Azure/azure-rest-api-specs/pull/5943

Feedback:

1. [KrisBash] TBD: Replace /settings/throughput with /settings/default (singleton) so that other settings can be added as properties (TBD as we may want to make settings explicit in the url)
2. [KrisBash] In cases where a static "resource name", such as /apis/cassandra/ are used, replace the static name with a "path parameter" and enum of allowed values