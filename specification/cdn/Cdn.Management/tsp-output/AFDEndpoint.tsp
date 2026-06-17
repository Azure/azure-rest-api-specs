import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * CDN endpoint is the entity within a CDN profile containing configuration information such as origin, protocol, content caching and delivery behavior. The AzureFrontDoor endpoint uses the URL format <endpointname>.azureedge.net.
 */
@parentResource(Profile)
model AFDEndpoint is TrackedResource<AFDEndpointProperties> {
  /**
   * Name of the endpoint under the profile which is unique globally.
   */
  @path
  @key("endpointName")
  @segment("afdEndpoints")
  name: string;
}

@armResourceOperations
interface AFDEndpoints {
  /**
   * Gets an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorEndpoints_Get")
  get is ArmResourceRead<AFDEndpoint>;

  /**
   * Creates a new AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorEndpoints_Create")
  create is ArmResourceCreateOrReplaceAsync<
    AFDEndpoint,
    BaseParameters<AFDEndpoint>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile. Only tags can be updated after creating an endpoint. To update origins, use the Update Origin operation. To update origin groups, use the Update Origin group operation. To update domains, use the Update Custom Domain operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("FrontDoorEndpoints_Update")
  update is ArmCustomPatchAsync<
    AFDEndpoint,
    AFDEndpointUpdateParameters,
    BaseParameters<AFDEndpoint>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes an existing AzureFrontDoor endpoint with the specified endpoint name under the specified subscription, resource group and profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorEndpoints_Delete")
  delete is ArmResourceDeleteAsync<
    AFDEndpoint,
    BaseParameters<AFDEndpoint>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists existing AzureFrontDoor endpoints.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorEndpoints_ListByProfile")
  listByProfile is ArmResourceListByParent<AFDEndpoint>;

  /**
   * Removes a content from AzureFrontDoor.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorEndpoints_PurgeContent")
  purgeContent is ArmResourceActionAsync<
    AFDEndpoint,
    FrontDoorPurgeParameters,
    void,
    BaseParameters<AFDEndpoint>,
    ArmAsyncOperationHeader
  >;

  /**
   * Checks the quota and actual usage of the given AzureFrontDoor endpoint under the given CDN profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorEndpoints_ListResourceUsage")
  listResourceUsage is ArmResourceActionSync<
    AFDEndpoint,
    void,
    UsagesListResult
  >;

  /**
   * Validates the custom domain mapping to ensure it maps to the correct CDN endpoint in DNS.This api isn't work for apex domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorEndpoints_ValidateCustomDomain")
  validateCustomDomain is ArmResourceActionSync<
    AFDEndpoint,
    ValidateCustomDomainContent,
    ValidateCustomDomainResult
  >;
}

@@projectedName(AFDEndpoints.create::parameters.resource,
  "json",
  "endpointInput"
);
@@extension(AFDEndpoints.create::parameters.resource,
  "x-ms-client-name",
  "endpointInput"
);
@@doc(AFDEndpoints.create::parameters.resource, "Endpoint properties");
@@projectedName(AFDEndpoints.update::parameters.properties,
  "json",
  "endpointUpdateProperties"
);
@@extension(AFDEndpoints.update::parameters.properties,
  "x-ms-client-name",
  "endpointUpdateProperties"
);
@@doc(AFDEndpoints.update::parameters.properties, "Endpoint update properties");
@@projectedName(AFDEndpoints.purgeContent::parameters.body, "json", "contents");
@@extension(AFDEndpoints.purgeContent::parameters.body,
  "x-ms-client-name",
  "contents"
);
@@doc(AFDEndpoints.purgeContent::parameters.body,
  "The list of paths to the content and the list of linked domains to be purged. Path can be a full URL, e.g. '/pictures/city.png' which removes a single file, or a directory with a wildcard, e.g. '/pictures/*' which removes all folders and files in the directory."
);
@@projectedName(AFDEndpoints.validateCustomDomain::parameters.body,
  "json",
  "customDomainProperties"
);
@@extension(AFDEndpoints.validateCustomDomain::parameters.body,
  "x-ms-client-name",
  "customDomainProperties"
);
@@doc(AFDEndpoints.validateCustomDomain::parameters.body,
  "Custom domain to be validated."
);
