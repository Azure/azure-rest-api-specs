import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./occurrencemodels.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.ComputeSchedule;

@added(Microsoft.ComputeSchedule.Versions.`2024-08-01-preview`)
@removed(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@renamedFrom(
  Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`,
  "Occurrences"
)
@armResourceOperations
interface OccurrencesOld {
  get is ArmResourceRead<OccurrenceOld>;
  listByAutoAction is ArmResourceListByParent<OccurrenceOld>;

  listResources is ArmResourceActionSync<
    OccurrenceOld,
    void,
    OccurrenceResourceListResponse
  >;
  cancel is ArmResourceActionSync<
    OccurrenceOld,
    CancelOccurrenceRequest,
    OccurrenceOld
  >;
  delay is ArmResourceActionSync<OccurrenceOld, DelayRequestOld, OccurrenceOld>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@armResourceOperations
interface Occurrences {
  get is ArmResourceRead<Occurrence>;
  listByScheduledAction is ArmResourceListByParent<Occurrence>;

  listResources is ArmResourceActionSync<
    Occurrence,
    void,
    OccurrenceResourceListResponse
  >;
  cancel is ArmResourceActionSync<
    Occurrence,
    CancelOccurrenceRequest,
    ResourceOperationResponse
  >;
  delay is ArmResourceActionAsync<
    Occurrence,
    DelayRequest,
    ResourceOperationResponse
  >;
}
