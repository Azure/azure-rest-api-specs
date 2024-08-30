namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface Addons {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("Addons_List")
  list is ArmResourceListByParent<
    Addon,
    Response = ArmResponse<ResourceList<Addon>>
  >;

  get is ArmResourceRead<Addon>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Addon,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<Addon>;
}

@@encodedName(Addons.createOrUpdate::parameters.resource,
  "application/json",
  "addon"
);
@@clientName(Addons.createOrUpdate::parameters.resource, "addon");
@@OpenAPI.extension(Addons.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "addon"
);
