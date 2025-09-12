import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.DependencyMap;

@doc("A Maps resource")
model MapsResource is TrackedResource<MapsResourceProperties> {
  @pattern("^[a-zA-Z][a-zA-Z0-9-]{2,23}$")
  @key("mapName")
  @segment("maps")
  @doc("Maps resource name")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("A Discovery Source resource")
@parentResource(MapsResource)
model DiscoverySourceResource
  is TrackedResource<DiscoverySourceResourceProperties> {
  @pattern("^[a-zA-Z][a-zA-Z0-9-]{2,23}$")
  @key("sourceName")
  @segment("discoverySources")
  @doc("discovery source resource")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}
