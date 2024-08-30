namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface WorkloadNetworkSegments {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListSegments")
  list is ArmResourceListByParent<
    WorkloadNetworkSegment,
    Response = ArmResponse<ResourceList<WorkloadNetworkSegment, "{name}sList">>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetSegment")
  get is ArmResourceRead<WorkloadNetworkSegment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @operationId("WorkloadNetworks_CreateSegments")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrUpdateAsync<
    WorkloadNetworkSegment,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_UpdateSegments")
  @parameterVisibility
  update is ArmCustomPatchAsync<WorkloadNetworkSegment, WorkloadNetworkSegment>;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("WorkloadNetworks_DeleteSegment")
  deleteSegment is ArmResourceDeleteAsync<WorkloadNetworkSegment>;
}

@@encodedName(WorkloadNetworkSegments.create::parameters.resource,
  "application/json",
  "workloadNetworkSegment"
);
@@clientName(WorkloadNetworkSegments.create::parameters.resource,
  "workloadNetworkSegment"
);
@@OpenAPI.extension(WorkloadNetworkSegments.create::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkSegment"
);

@@encodedName(WorkloadNetworkSegments.update::parameters.properties,
  "application/json",
  "workloadNetworkSegment"
);
@@clientName(WorkloadNetworkSegments.update::parameters.properties,
  "application/json",
  "workloadNetworkSegment"
);
@@OpenAPI.extension(WorkloadNetworkSegments.update::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkSegment"
);
