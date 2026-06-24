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

namespace Microsoft.Compute;

@armResourceOperations
interface Occurrences {
  get is ArmResourceRead<Occurrence>;
  listByScheduledAction is ArmResourceListByParent<Occurrence>;

  @autoRoute
  @listsResource(OccurrenceResource)
  @armResourceList(OccurrenceResource)
  @list
  @get
  @doc("List resources attached to Scheduled Actions for the given occurrence")
  listResources(...ResourceInstanceParameters<OccurrenceResource>):
    | ArmResponse<OccurrenceResourceListResponse>
    | ErrorResponse;

  cancel is ArmResourceActionAsync<
    Occurrence,
    CancelOccurrenceRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  delay is ArmResourceActionAsync<
    Occurrence,
    DelayRequest,
    ResourceOperationResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ResourceOperationResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@armResourceOperations
interface OccurrenceExtension {
  listOccurrenceByVms is ArmResourceListByParent<OccurrenceExtensionResource>;
}
