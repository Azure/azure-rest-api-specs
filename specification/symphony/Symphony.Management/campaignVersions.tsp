import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
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
  @pattern("^(?!v-)(?!.*-v-)[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  @madeOptional(Versions.v2024_08_01_preview)
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface CampaignVersions {
  @doc("Returns the details of the campaignVersion.")
  get is Azure.ResourceManager.ArmResourceRead<CampaignVersion>;
  @doc("Creates a new or updates an existing campaignVersion.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<CampaignVersion>;
  @doc("Updates an existing campaignVersion.")
  update is ArmCustomPatchAsync<CampaignVersion>;
  @doc("Deletes a specified campaignVersion.")
  delete is ArmResourceDeleteWithoutOkAsync<CampaignVersion>;
  @doc("Lists CampaignVersions within a Campaign.")
  listByCampaign is ArmResourceListByParent<CampaignVersion>;
}
