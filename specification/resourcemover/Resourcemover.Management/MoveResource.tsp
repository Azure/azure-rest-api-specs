import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MoveCollection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Migrate;
/**
 * Defines the move resource.
 */
@parentResource(MoveCollection)
model MoveResource
  is Azure.ResourceManager.ProxyResource<MoveResourceProperties> {
  ...ResourceNameParameter<
    Resource = MoveResource,
    KeyName = "moveResourceName",
    SegmentName = "moveResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MoveResources {
  /**
   * Gets the Move Resource.
   */
  get is ArmResourceRead<MoveResource>;

  /**
   * Creates or updates a Move Resource in the move collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    MoveResource,
    Response = ArmResourceUpdatedResponse<MoveResource> | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a Move Resource from the move collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    MoveResource,
    Response = ArmResponse<OperationStatus> | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the Move Resources in the move collection.
   */
  list is ArmResourceListByParent<
    MoveResource,
    Parameters = {
      /**
       * The filter to apply on the operation. For example, you can use $filter=Properties/ProvisioningState eq 'Succeeded'.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<MoveResourceCollection>
  >;
}

@@doc(MoveResource.name, "The Move Resource Name.");
@@doc(MoveResource.properties, "Defines the move resource properties.");
@@doc(MoveResources.create::parameters.resource, "");
