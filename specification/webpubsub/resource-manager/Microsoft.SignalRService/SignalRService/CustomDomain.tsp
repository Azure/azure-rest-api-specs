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
  get is ArmResourceRead<CustomDomain>;

  /**
   * Create or update a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomDomain,
    Response = ArmResourceCreatedResponse<
      CustomDomain,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = CustomDomain>
    > | ErrorResponse
  >;

  /**
   * Delete a custom domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomDomain,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
      | ErrorResponse
  >;

  /**
   * List all custom domains.
   */
  list is ArmResourceListByParent<
    CustomDomain,
    Response = ArmResponse<CustomDomainList>
  >;
}

@@doc(CustomDomain.name, "Custom domain name.");
@@doc(CustomDomain.properties, "Properties of a custom domain.");
@@doc(CustomDomains.createOrUpdate::parameters.resource, "");
