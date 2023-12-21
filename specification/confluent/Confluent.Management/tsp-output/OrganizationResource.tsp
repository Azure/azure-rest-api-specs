import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Confluent;
@doc("Organization resource.")
model OrganizationResource is TrackedResource<OrganizationResourceProperties> {
  @doc("Organization resource name")
  @path
  @key("organizationName")
  @segment("organizations")
  name: string;
}

@armResourceOperations
interface Organization {
  @doc("Get the properties of a specific Organization resource.")
  get is ArmResourceRead<OrganizationResource>;
  @doc("Create Organization resource")
  create is ArmResourceCreateOrUpdateAsync<OrganizationResource>;
  @doc("Update Organization resource")
  update is ArmTagsPatchSync<OrganizationResource>;
  @doc("Delete Organization resource")
  delete is ArmResourceDeleteAsync<OrganizationResource>;
  @doc("List all Organizations under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  @doc("List all organizations under the specified subscription.")
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}
