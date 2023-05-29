import "./CollectorProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Hyper-V collector resource.")
@parentResource(AssessmentProject)
model HypervCollector is ProxyResource<CollectorPropertiesBaseWithAgent> {
    @doc("Hyper-V collector ARM name")
    @key("hyperCollectorName")
    @segment("hypervcollectors")
    @path
    name: string;
}
