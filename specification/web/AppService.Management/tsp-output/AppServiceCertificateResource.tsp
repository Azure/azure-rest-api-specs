import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceCertificateOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Key Vault container ARM resource for a certificate that is purchased through Azure.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AppServiceCertificateOrder)
@includeInapplicableMetadataInPayload(false)
model AppServiceCertificateResource extends Resource {
  /**
   * Name of the certificate.
   */
  @path
  @key("name")
  @segment("certificates")
  @visibility("read")
  name: string;

  /**
   * Core resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: AppServiceCertificate;
}

@armResourceOperations
interface AppServiceCertificateResources {
  /**
   * Description for Get the certificate associated with a certificate order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceCertificateOrders_GetCertificate")
  getCertificate is ArmResourceRead<AppServiceCertificateResource>;

  /**
   * Description for Creates or updates a certificate and associates with key vault secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceCertificateOrders_CreateOrUpdateCertificate")
  createOrUpdateCertificate is ArmResourceCreateOrReplaceAsync<AppServiceCertificateResource>;

  /**
   * Description for Creates or updates a certificate and associates with key vault secret.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("AppServiceCertificateOrders_UpdateCertificate")
  updateCertificate is ArmCustomPatchSync<
    AppServiceCertificateResource,
    AppServiceCertificatePatchResource
  >;

  /**
   * Description for Delete the certificate associated with a certificate order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceCertificateOrders_DeleteCertificate")
  deleteCertificate is ArmResourceDeleteSync<AppServiceCertificateResource>;

  /**
   * Description for List all certificates associated with a certificate order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceCertificateOrders_ListCertificates")
  listCertificates is ArmResourceListByParent<AppServiceCertificateResource>;
}

@@projectedName(AppServiceCertificateResources.createOrUpdateCertificate::parameters.resource,
  "json",
  "keyVaultCertificate"
);
@@extension(AppServiceCertificateResources.createOrUpdateCertificate::parameters.resource,
  "x-ms-client-name",
  "keyVaultCertificate"
);
@@doc(AppServiceCertificateResources.createOrUpdateCertificate::parameters.resource,
  "Key vault certificate resource Id."
);
@@projectedName(AppServiceCertificateResources.updateCertificate::parameters.properties,
  "json",
  "keyVaultCertificate"
);
@@extension(AppServiceCertificateResources.updateCertificate::parameters.properties,
  "x-ms-client-name",
  "keyVaultCertificate"
);
@@doc(AppServiceCertificateResources.updateCertificate::parameters.properties,
  "Key vault certificate resource Id."
);
