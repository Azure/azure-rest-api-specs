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

  /**
   * Kind of resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface AppServiceCertificateResources {
  /**
   * Description for Get the certificate associated with a certificate order.
   */
  getCertificate is ArmResourceRead<
    AppServiceCertificateResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates a certificate and associates with key vault secret.
   */
  createOrUpdateCertificate is ArmResourceCreateOrReplaceAsync<
    AppServiceCertificateResource,
    Response = ArmResponse<AppServiceCertificateResource> | ArmResourceCreatedResponse<
      AppServiceCertificateResource,
      LroHeaders = ArmLroLocationHeader<FinalResult = AppServiceCertificateResource>
    >,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Creates or updates a certificate and associates with key vault secret.
   */
  @patch(#{ implicitOptionality: false })
  updateCertificate is ArmCustomPatchSync<
    AppServiceCertificateResource,
    PatchModel = AppServiceCertificatePatchResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Delete the certificate associated with a certificate order.
   */
  deleteCertificate is ArmResourceDeleteSync<
    AppServiceCertificateResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for List all certificates associated with a certificate order.
   */
  listCertificates is ArmResourceListByParent<
    AppServiceCertificateResource,
    Response = ArmResponse<AppServiceCertificateCollection>,
    Error = DefaultErrorResponse
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
@@summary(AppServiceCertificateResources.deleteCertificate,
  "Delete the certificate associated with a certificate order."
);
@@summary(AppServiceCertificateResources.listCertificates,
  "List all certificates associated with a certificate order."
);
@@summary(AppServiceCertificateResources.getCertificate,
  "Get the certificate associated with a certificate order."
);
@@summary(AppServiceCertificateResources.createOrUpdateCertificate,
  "Creates or updates a certificate and associates with key vault secret."
);
@@summary(AppServiceCertificateResources.updateCertificate,
  "Creates or updates a certificate and associates with key vault secret."
);
