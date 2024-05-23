import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ToolchainOrchestrator;

@doc("Defining the CampaignVersion.")
model CampaignVersionProperties {
  @doc("Provisioning state of the campaignVersion.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The initial stage of the CampaignVersion.")
  firstStage?: string;

  @doc("Whether campaign is self driving or not. That is whether a stage should trigger the next stage when it finishes.")
  selfDriving?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The stages of the CampaignVersion.")
  stages?: Record<StageProperties>;
}

@doc("The campaignVersion entity. A nested resource of Campaign entity")
@resource("versions")
@parentResource(Campaign)
model CampaignVersion is TrackedResource<CampaignVersionProperties> {
  @doc("The name of the campaignVersion.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]+(\\.[a-z0-9]+)*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface CampaignVersions {
  @doc("Returns the details of the campaignVersion.")
  get is Azure.ResourceManager.ArmResourceRead<CampaignVersion>;
  @doc("Creates a new or updates an existing campaignVersion.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<CampaignVersion>;
  @doc("Updates an existing campaignVersion.")
  update is ArmCustomPatchSync<CampaignVersion>;
  @doc("Deletes a specified campaignVersion.")
  delete is ArmResourceDeleteSync<CampaignVersion>;
  @doc("Lists CampaignVersions within a Campaign.")
  listByCampaign is ArmResourceListByParent<CampaignVersion>;
}
