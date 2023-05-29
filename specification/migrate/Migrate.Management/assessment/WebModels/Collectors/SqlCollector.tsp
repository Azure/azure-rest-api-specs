import "./CollectorProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("The SQL collector REST object.")
@parentResource(AssessmentProject)
model SqlCollector  is ProxyResource<CollectorPropertiesBaseWithAgent>{
    @doc("Sql collector ARM name.")
    @key("collectorName")
    @segment("sqlcollectors")
    @path
    name: string;
}