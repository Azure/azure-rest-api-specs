namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface CloudLinks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("CloudLinks_List")
  list is ArmResourceListByParent<
    CloudLink,
    Response = ArmResponse<ResourceList<CloudLink>>
  >;

  get is ArmResourceRead<CloudLink>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    CloudLink,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<CloudLink>;
}

@@encodedName(CloudLinks.createOrUpdate::parameters.resource,
  "application/json",
  "cloudLink"
);
@@clientName(CloudLinks.createOrUpdate::parameters.resource, "cloudLink");
@@OpenAPI.extension(CloudLinks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cloudLink"
);
