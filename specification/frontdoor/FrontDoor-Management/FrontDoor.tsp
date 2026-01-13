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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model FrontDoor extends Resource {
  properties?: FrontDoorProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("frontDoorName")
  @segment("frontDoors")
  @pattern("^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$")
  name: string;
}

@armResourceOperations
interface FrontDoors {
  /**
   * Gets a Front Door with the specified Front Door name under the specified subscription and resource group.
   */
  get is ArmResourceRead<FrontDoor, Error = ErrorResponse>;

  /**
   * Creates a new Front Door with a Front Door name under the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FrontDoor,
    Response = ArmResourceUpdatedResponse<FrontDoor> | ArmResourceCreatedResponse<
      FrontDoor,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = FrontDoor> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = FrontDoor>> &
      Azure.Core.Foundations.RetryAfterHeader & {
        @bodyRoot
        _: FrontDoor;
      }),
    Error = ErrorResponse
  >;

  /**
   * Deletes an existing Front Door with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FrontDoor,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Lists all of the Front Doors within a resource group under a subscription.
   */
  listByResourceGroup is ArmResourceListByParent<
    FrontDoor,
    Response = FrontDoorListResult,
    Error = ErrorResponse
  >;

  /**
   * Lists all of the Front Doors within an Azure subscription.
   */
  list is ArmListBySubscription<
    FrontDoor,
    Response = FrontDoorListResult,
    Error = ErrorResponse
  >;

  /**
   * Validates the custom domain mapping to ensure it maps to the correct Front Door endpoint in DNS.
   */
  validateCustomDomain is ArmResourceActionSync<
    FrontDoor,
    ValidateCustomDomainInput,
    ArmResponse<ValidateCustomDomainOutput>,
    Error = ErrorResponse
  >;

  /**
   * Removes a content from Front Door.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Endpoints_PurgeContent")
  @action("purge")
  purgeContent is ArmResourceActionAsync<
    FrontDoor,
    PurgeParameters,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
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
