import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./autoactionmodels.tsp";
import "./occurrencemodels.tsp";
import "./occurrenceroutes.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.ComputeSchedule;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@armResourceOperations
interface AutoActions {
  get is ArmResourceRead<AutoAction>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AutoAction>;
  update is ArmResourcePatchSync<AutoAction, AutoActionProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AutoAction>;
  listByResourceGroup is ArmResourceListByParent<AutoAction>;
  listBySubscription is ArmListBySubscription<AutoAction>;

  listResources is ArmResourceActionSync<
    AutoAction,
    void,
    AutoActionResourceListResponse
  >;
  attachResources is ArmResourceActionSync<
    AutoAction,
    AutoActionResourceAttachRequest,
    AutoActionResourceOperationResponse
  >;
  detachResources is ArmResourceActionSync<
    AutoAction,
    AutoActionResourceDetachRequest,
    AutoActionResourceOperationResponse
  >;
  patchResources is ArmResourceActionSync<
    AutoAction,
    AutoActionResourcePatchRequest,
    AutoActionResourceOperationResponse
  >;

  disable is ArmResourceActionSync<AutoAction, void, OkResponse>;
  enable is ArmResourceActionSync<AutoAction, void, OkResponse>;

  cancelNextOccurrence is ArmResourceActionSync<
    AutoAction,
    CancelOccurrenceRequest,
    OccurrenceOld
  >;
  triggerManualOccurrence is ArmResourceActionSync<
    AutoAction,
    void,
    OccurrenceOld
  >;
}

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@armResourceOperations
interface AutoActionsExtension {
  listByVms is ArmResourceListByParent<AutoActionResources>;
}
