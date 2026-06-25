import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Deleted API Management Service information.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model DeletedServiceContract
  is Azure.ResourceManager.ProxyResource<DeletedServiceContractProperties> {
  ...ResourceNameParameter<
    Resource = DeletedServiceContract,
    KeyName = "serviceName",
    SegmentName = "deletedservices",
    NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
  >;

  /**
   * API Management Service Master Location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

// ResourceName = "ApiManagementDeletedService" makes the C# emitter produce
// ApiManagementDeletedServiceResource.cs / Collection.cs (matching GA contract).
// Subscription+location-scoped (no resource group).
@armResourceOperations
interface DeletedServiceContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,
      },
      {
        /** The name of the API Management service. */
        @path
        @segment("deletedservices")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      ResourceName = "ApiManagementDeletedService"
    > {}

@armResourceOperations
interface DeletedServiceContracts {
  /**
   * Get soft-deleted Api Management Service by name.
   */
  getByName is DeletedServiceContractOps.Read<DeletedServiceContract>;

  /**
   * Purges Api Management Service (deletes it with no option to undelete).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  purge is DeletedServiceContractOps.DeleteWithoutOkAsync<
    DeletedServiceContract,
    Response =
      | ArmDeletedResponse
      | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = void>> & {
          @bodyRoot
          _: DeletedServiceContract;
        })
      | ArmDeletedNoContentResponse
  >;
}

@@maxLength(DeletedServiceContract.name, 50);
@@minLength(DeletedServiceContract.name, 1);
@@doc(DeletedServiceContract.name, "The name of the API Management service.");
@@doc(
  DeletedServiceContract.properties,
  "Deleted API Management Service details."
);
