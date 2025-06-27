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
 * A custom certificate.
 */
@parentResource(WebPubSubResource)
model CustomCertificate
  is Azure.ResourceManager.ProxyResource<CustomCertificateProperties, false> {
  ...ResourceNameParameter<
    Resource = CustomCertificate,
    KeyName = "certificateName",
    SegmentName = "customCertificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CustomCertificates {
  /**
   * Get a custom certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSubCustomCertificates_Get")
  get is ArmResourceRead<CustomCertificate>;

  /**
   * Create or update a custom certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSubCustomCertificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomCertificate,
    Parameters = {
      @header
      contentType: "application/json" | "text/json";
    }
  >;

  /**
   * Delete a custom certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSubCustomCertificates_Delete")
  delete is ArmResourceDeleteSync<CustomCertificate>;

  /**
   * List all custom certificates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSubCustomCertificates_List")
  list is ArmResourceListByParent<
    CustomCertificate,
    Response = ArmResponse<CustomCertificateList>
  >;
}

@@doc(CustomCertificate.name, "Custom certificate name");
@@doc(CustomCertificate.properties, "Custom certificate properties.");
@@doc(CustomCertificates.createOrUpdate::parameters.resource, "");
