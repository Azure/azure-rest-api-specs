import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceCertificateOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Key Vault container ARM resource for a certificate that is purchased through Azure.
 */
@parentResource(AppServiceCertificateOrder)
model AppServiceCertificateResource
  is Azure.ResourceManager.TrackedResource<AppServiceCertificate> {
  ...ResourceNameParameter<
    Resource = AppServiceCertificateResource,
    KeyName = "name",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AppServiceCertificateResources {
  /**
   * Description for Get the certificate associated with a certificate order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceCertificateOrders_GetCertificate")
  @tag("AppServiceCertificateOrders")
  getCertificate is ArmResourceRead<AppServiceCertificateResource>;

  /**
   * Description for Creates or updates a certificate and associates with key vault secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceCertificateOrders_CreateOrUpdateCertificate")
  createOrUpdateCertificate is ArmResourceCreateOrReplaceAsync<
    AppServiceCertificateResource,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Creates or updates a certificate and associates with key vault secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceCertificateOrders_UpdateCertificate")
  @patch(#{ implicitOptionality: false })
  updateCertificate is ArmCustomPatchSync<
    AppServiceCertificateResource,
    PatchModel = AppServiceCertificatePatchResource
  >;

  /**
   * Description for Delete the certificate associated with a certificate order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceCertificateOrders_DeleteCertificate")
  deleteCertificate is ArmResourceDeleteSync<AppServiceCertificateResource>;

  /**
   * Description for List all certificates associated with a certificate order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceCertificateOrders_ListCertificates")
  listCertificates is ArmResourceListByParent<
    AppServiceCertificateResource,
    Response = ArmResponse<AppServiceCertificateCollection>
  >;
}

@@doc(AppServiceCertificateResource.name, "Name of the certificate.");
@@doc(AppServiceCertificateResource.properties, "Core resource properties");
@@doc(AppServiceCertificateResources.createOrUpdateCertificate::parameters.resource,
  "Key vault certificate resource Id."
);
@@doc(AppServiceCertificateResources.updateCertificate::parameters.properties,
  "Key vault certificate resource Id."
);
