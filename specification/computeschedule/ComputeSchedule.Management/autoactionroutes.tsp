import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./autoactionmodels.tsp";
import "./occurrencemodels.tsp";
import "./occurrenceroutes.tsp";
import "./commons.tsp";

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

  @segment("resources")
  getResources is ArmResourceListActionSync<AutoAction, AutoActionResource>;
  attachResources is ArmResourceActionNoContentSync<
    AutoAction,
    AutoActionResource[]
  >;
  detachResources is ArmResourceActionNoContentSync<
    AutoAction,
    AutoActionResource[]
  >;

  @doc("disables the auto action")
  disable is ArmResourceActionNoContentNoResponseSync<AutoAction>;
  @doc("enables the auto action")
  enable is ArmResourceActionNoContentNoResponseSync<AutoAction>;

  cancelNextOccurrence is ArmResourceActionAsync<
    AutoAction,
    OccurrenceResource[],
    Occurrence
  >;
  triggerManualOccurrence is ArmResourceActionAsync<
    AutoAction,
    void,
    Occurrence
  >;

  @doc("List auto actions associated to the resource. This is intended to be used for Microsoft.Compute/virtualMachines only")
  @segment("autoActions")
  listByVms is Azure.ResourceManager.Foundations.ArmReadOperation<
    ResourceUriParameter &
      Azure.ResourceManager.Foundations.TenantScope<AutoAction>,
    ArmResponse<ResourceListResult<AutoAction>>,
    ErrorResponse
  >;
}
