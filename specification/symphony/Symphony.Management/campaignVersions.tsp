import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Symphony;

@doc("Defining the CampaignVersion.")
model CampaignVersionProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The firstStage of the CampaignVersion.")
  firstStage?: string;

  @doc("The selfDriving of the CampaignVersion.")
  selfDriving?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The stages of the CampaignVersion.")
  stages?: Record<StageProperties>;
}

@doc("The service entity.")
@resource("versions")
@parentResource(Campaign)
model CampaignVersion is TrackedResource<CampaignVersionProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
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
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<CampaignVersion>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<CampaignVersion>;
  @doc("Updates existing service.")
  update is ArmCustomPatchSync<CampaignVersion>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<CampaignVersion>;

  listByParent is ArmResourceListByParent<CampaignVersion>;
}