import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of the campaign.")
model CampaignProperties {
  @doc("Provisioning state of the campaign.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The campaign entity.")
model Campaign is TrackedResource<CampaignProperties> {
  @doc("The name of the campaign.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("campaignName")
  @segment("campaigns")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Campaigns {
  @doc("Returns the details of the campaign.")
  get is Azure.ResourceManager.ArmResourceRead<Campaign>;
  @doc("Creates a new or updates an existing campaign.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<Campaign>;
  @doc("Updates an existing campaign.")
  update is ArmCustomPatchAsync<Campaign>;
  @doc("Deletes a specified campaign.")
  delete is ArmResourceDeleteWithoutOkAsync<Campaign>;
  @doc("Returns a collection of campaigns within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Campaign>;
  @doc("Lists campaigns within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Campaign>;
}
