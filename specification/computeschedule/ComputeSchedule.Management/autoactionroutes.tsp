import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./autoactionmodels.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.ComputeSchedule;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@armResourceOperations
interface AutoActions {
  get is ArmResourceRead<AutoAction>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AutoAction>;
  update is ArmResourcePatchSync<AutoAction, AutoActionProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AutoAction>;
  listByResourceGroup is ArmResourceListByParent<AutoAction>;
  listBySubscription is ArmListBySubscription<AutoAction>;

  @doc("Lists Auto actions per VM.")
  @segment("autoActions")
  @OpenAPI.extension(
  "x-ms-pageable",
  {
    nextLinkName: "nextLink",
  }
)
  @armResourceList(AutoAction)
  @get
  listByVm(
    ...AutoActionParams
  ): ArmResponse<AutoAction[]> | ErrorResponse;

  attachResources is ArmResourceActionNoContentSync<
    AutoAction,
    armResourceIdentifier[]
  >;
  detachResources is ArmResourceActionNoContentSync<
    AutoAction,
    armResourceIdentifier[]
  >;

  disable is ArmResourceActionNoContentSync<AutoAction, void>;
  enable is ArmResourceActionNoContentSync<AutoAction, void>;
  cancelNextOccurrence is ArmResourceActionNoResponseContentAsync<AutoAction, void>;
  triggerManualOccurrence is ArmResourceActionNoResponseContentAsync<AutoAction, void>;
}