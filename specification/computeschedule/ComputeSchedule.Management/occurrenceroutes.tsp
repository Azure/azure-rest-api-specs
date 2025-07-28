import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./occurrencemodels.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ComputeSchedule;

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@armResourceOperations
interface Occurrences {
  get is ArmResourceRead<Occurrence>;
  listByScheduledAction is ArmResourceListByParent<Occurrence>;

  @autoRoute
  @listsResource(OccurrenceResource)
  @armResourceList(OccurrenceResource)
  @get
  @doc("List resources attached to Scheduled Actions for the given occurrence")
  listResources(
    ...ResourceInstanceParameters<OccurrenceResource>,
  ): ArmResponse<OccurrenceResourceListResponse> | ErrorResponse;
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

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@armResourceOperations
interface OccurrenceExtension {
  listOccurrenceByVms is ArmResourceListByParent<OccurrenceExtensionResource>;
}
