import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Fabric;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" ""
#suppress "@typespec/http/metadata-ignored" ""
@doc("PrivateLinkResource Object")
@parentResource(PrivateLinkServiceForFabric)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("Name")
  @key("privateLinkResourceName")
  @path
  @segment("privateLinkResources")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("PrivateLinkResource Properties")
model PrivateLinkResourceProperties {
  @doc("Group Id")
  @visibility(Lifecycle.Read)
  groupId: string;

  @doc("Required Members")
  @visibility(Lifecycle.Read)
  requiredMembers: string[];

  @visibility(Lifecycle.Read)
  @doc("Required Zone Names")
  requiredZoneNames: string[];
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Get private link resource")
  get is ArmResourceRead<PrivateLinkResource>;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @doc("List private link resources of private link service for Fabric")
  @operationId("PrivateLinkResources_List")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
