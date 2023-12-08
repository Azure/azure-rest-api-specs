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
model ConfluentOrganization is TrackedResource<OrganizationResourceProperties> {
  @doc("Organization resource name")
  @path
  @key("organizationName")
  @segment("organizations")
  name: string;
}

@armResourceOperations
interface ConfluentOrganizations {
  @doc("Get the properties of a specific Organization resource.")
  get is ArmResourceRead<ConfluentOrganization>;
  @doc("Create Organization resource")
  create is ArmResourceCreateOrUpdateAsync<ConfluentOrganization>;
  @doc("Update Organization resource")
  update is ArmTagsPatchSync<ConfluentOrganization>;
  @doc("Delete Organization resource")
  delete is ArmResourceDeleteAsync<ConfluentOrganization>;
  @doc("List all Organizations under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<ConfluentOrganization>;
  @doc("List all organizations under the specified subscription.")
  listBySubscription is ArmListBySubscription<ConfluentOrganization>;
}
