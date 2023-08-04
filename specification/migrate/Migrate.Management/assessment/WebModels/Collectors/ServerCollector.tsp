import "./CollectorProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Physical server collector resource.")
@parentResource(AssessmentProject)
model ServerCollector is ProxyResource<CollectorPropertiesBaseWithAgent> {
    @doc("Physical server collector ARM name")
    @key("serverCollectorName")
    @segment("servercollectors")
    @path
    name: string;
}
