import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Confluent;
@doc("Organization resource.")
model OrganizationResource is TrackedResource<OrganizationResourceProperties> {
  @doc("Organization resource name")
  @key("organizationName")
  @segment("organizations")
  name: string;
}

@armResourceOperations
@projectedName("client", "Organization")
interface OrganizationResources_Organization {
  @doc("Get the properties of a specific Organization resource.")
  get is ArmResourceRead<OrganizationResource>;

  @doc("Create Organization resource")
  create is ArmResourceCreateOrUpdateAsync<OrganizationResource>;

  @doc("Update Organization resource")
  update is ArmCustomPatchSync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;

  @doc("Delete Organization resource")
  delete is ArmResourceDeleteAsync<OrganizationResource>;

  @doc("List all Organizations under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;

  @doc("List all organizations under the specified subscription.")
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}
