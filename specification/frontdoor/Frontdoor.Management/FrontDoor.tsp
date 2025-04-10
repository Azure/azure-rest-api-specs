import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Front Door represents a collection of backend endpoints to route traffic to along with rules that specify how traffic is sent there.
 */
model FrontDoor is Azure.ResourceManager.TrackedResource<FrontDoorProperties> {
  ...ResourceNameParameter<
    Resource = FrontDoor,
    KeyName = "frontDoorName",
    SegmentName = "frontDoors",
    NamePattern = "^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$"
  >;
}

@armResourceOperations
interface FrontDoors {
  /**
   * Gets a Front Door with the specified Front Door name under the specified subscription and resource group.
   */
  get is ArmResourceRead<FrontDoor>;

  /**
   * Creates a new Front Door with a Front Door name under the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FrontDoor,
    Response = ArmResourceUpdatedResponse<FrontDoor> | ArmResourceCreatedResponse<FrontDoor> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: FrontDoor;
    })
  >;

  /**
   * Deletes an existing Front Door with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    FrontDoor,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all of the Front Doors within a resource group under a subscription.
   */
  listByResourceGroup is ArmResourceListByParent<FrontDoor>;

  /**
   * Lists all of the Front Doors within an Azure subscription.
   */
  list is ArmListBySubscription<FrontDoor>;

  /**
   * Validates the custom domain mapping to ensure it maps to the correct Front Door endpoint in DNS.
   */
  validateCustomDomain is ArmResourceActionSync<
    FrontDoor,
    ValidateCustomDomainInput,
    ArmResponse<ValidateCustomDomainOutput>
  >;

  /**
   * Removes a content from Front Door.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("purge")
  @operationId("Endpoints_PurgeContent")
  purgeContent is ArmResourceActionAsync<
    FrontDoor,
    PurgeParameters,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@maxLength(FrontDoor.name, 64);
@@minLength(FrontDoor.name, 5);
@@doc(FrontDoor.name, "Name of the Front Door which is globally unique.");
@@doc(FrontDoor.properties, "Properties of the Front Door Load Balancer");
@@doc(FrontDoors.createOrUpdate::parameters.resource,
  "Front Door properties needed to create a new Front Door."
);
@@doc(FrontDoors.validateCustomDomain::parameters.body,
  "Custom domain to be validated."
);
@@doc(FrontDoors.purgeContent::parameters.body,
  "The path to the content to be purged. Path can be a full URL, e.g. '/pictures/city.png' which removes a single file, or a directory with a wildcard, e.g. '/pictures/*' which removes all folders and files in the directory."
);
