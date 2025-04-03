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
@armResourceOperations
interface Occurrences {
  get is ArmResourceRead<Occurrence>;
  listByAutoAction is ArmResourceListByParent<Occurrence>;

  listResources is ArmResourceActionSync<
    Occurrence,
    void,
    OccurrenceResourceListResponse
  >;
  cancel is ArmResourceActionSync<
    Occurrence,
    CancelOccurrenceRequest,
    Occurrence
  >;
  delay is ArmResourceActionSync<Occurrence, DelayRequest, Occurrence>;
}