import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Front Door represents a collection of backend endpoints to route traffic to along with rules that specify how traffic is sent there.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(FrontDoorProperties)
@includeInapplicableMetadataInPayload(false)
model FrontDoor extends FrontDoorResourceModel {
  /**
   * Name of the Front Door which is globally unique.
   */
  @maxLength(64)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]+([-a-zA-Z0-9]?[a-zA-Z0-9])*$")
  @path
  @key("frontDoorName")
  @segment("frontDoors")
  name: string;

  /**
   * Properties of the Front Door Load Balancer
   */
  @extension("x-ms-client-flatten", true)
  properties?: FrontDoorProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FrontDoor,
    BaseParameters<FrontDoor>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes an existing Front Door with the specified parameters.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    FrontDoor,
    BaseParameters<FrontDoor>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the Front Doors within a resource group under a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoors_ListByResourceGroup")
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
    ValidateCustomDomainOutput
  >;

  /**
   * Removes a content from Front Door.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Endpoints_PurgeContent")
  purgeContent is ArmResourceActionAsync<
    FrontDoor,
    PurgeParameters,
    void,
    BaseParameters<FrontDoor>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(FrontDoors.createOrUpdate::parameters.resource,
  "json",
  "frontDoorParameters"
);
@@extension(FrontDoors.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "frontDoorParameters"
);
@@doc(FrontDoors.createOrUpdate::parameters.resource,
  "Front Door properties needed to create a new Front Door."
);
@@projectedName(FrontDoors.validateCustomDomain::parameters.body,
  "json",
  "customDomainProperties"
);
@@extension(FrontDoors.validateCustomDomain::parameters.body,
  "x-ms-client-name",
  "customDomainProperties"
);
@@doc(FrontDoors.validateCustomDomain::parameters.body,
  "Custom domain to be validated."
);
@@projectedName(FrontDoors.purgeContent::parameters.body,
  "json",
  "contentFilePaths"
);
@@extension(FrontDoors.purgeContent::parameters.body,
  "x-ms-client-name",
  "contentFilePaths"
);
@@doc(FrontDoors.purgeContent::parameters.body,
  "The path to the content to be purged. Path can be a full URL, e.g. '/pictures/city.png' which removes a single file, or a directory with a wildcard, e.g. '/pictures/*' which removes all folders and files in the directory."
);
