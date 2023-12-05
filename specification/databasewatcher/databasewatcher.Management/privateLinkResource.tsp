import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

namespace Microsoft.DatabaseWatcher;

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;

@added(Versions.v2023_09_01_preview)
@armResourceOperations
interface PrivateLinkResources
  extends ResourceListByParent<PrivateLinkResource> {}

#suppress "@azure-tools/typespec-providerhub-controller/no-resource-operations" "Expected for private links"
@added(Versions.v2023_09_01_preview)
@parentResource(Watcher)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  ...PrivateLinkResourceParameter;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Matches current common code"
@added(Versions.v2023_09_01_preview)
@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource private link DNS zone name.")
  @visibility("read")
  requiredZoneNames?: string[];

  @doc("The list of resource types that support Azure Private Link, and are supported by database watcher.")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  shareablePrivateLinkResourceTypes?: ShareablePrivateLinkResourceType[];
}

@added(Versions.v2023_09_01_preview)
@doc("The resources that that support Azure Private Link, and are supported by database watcher.")
model ShareablePrivateLinkResourceType {
  @visibility("read")
  @doc("The name of the resource type that supports Azure Private Link, supported by database watcher.")
  name: string;

  @visibility("read")
  @doc("The properties of a resource type that supports Azure Private Link, supported by database watcher.")
  properties: ShareablePrivateLinkResourceProperties;
}

@added(Versions.v2023_09_01_preview)
@doc("The properties of a resource type that supports Azure Private Link, supported by database watcher.")
model ShareablePrivateLinkResourceProperties {
  @visibility("read")
  @doc("The resource provider type for the resource that supports Azure Private Link.")
  type: string;

  @visibility("read")
  @doc("The resource provider group id for the resource that supports Azure Private Link.")
  groupId: string;

  @visibility("read")
  @doc("The description of the resource type that supports Azure Private Link.")
  description: string;
}
