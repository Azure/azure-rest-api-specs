import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebPubSubResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * A custom domain
 */
@parentResource(WebPubSubResource)
model CustomDomain
  is Azure.ResourceManager.ProxyResource<CustomDomainProperties, false> {
  ...ResourceNameParameter<
    Resource = CustomDomain,
    KeyName = "name",
    SegmentName = "customDomains",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CustomDomains {
  /**
   * Get a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubCustomDomains_Get")
  get is ArmResourceRead<CustomDomain>;

  /**
   * Create or update a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebPubSubCustomDomains_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomDomain,
    Response = ArmResourceCreatedResponse<CustomDomain>
  >;

  /**
   * Delete a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebPubSubCustomDomains_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomDomain,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all custom domains.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubCustomDomains_List")
  list is ArmResourceListByParent<
    CustomDomain,
    Response = ArmResponse<CustomDomainList>
  >;
}

@@doc(CustomDomain.name, "Custom domain name.");
@@doc(CustomDomain.properties, "Properties of a custom domain.");
@@doc(CustomDomains.createOrUpdate::parameters.resource, "");
