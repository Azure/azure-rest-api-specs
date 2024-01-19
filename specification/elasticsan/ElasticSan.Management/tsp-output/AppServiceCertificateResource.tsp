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
@doc("Key Vault container ARM resource for a certificate that is purchased through Azure.")
@parentResource(AppServiceCertificateOrder)
model AppServiceCertificateResource is TrackedResource<AppServiceCertificate> {
  @doc("Name of the certificate.")
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface AppServiceCertificateResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get the certificate associated with a certificate order.")
  @operationId("AppServiceCertificateOrders_GetCertificate")
  getCertificate is ArmResourceRead<AppServiceCertificateResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates or updates a certificate and associates with key vault secret.")
  @operationId("AppServiceCertificateOrders_CreateOrUpdateCertificate")
  createOrUpdateCertificate is ArmResourceCreateOrUpdateAsync<AppServiceCertificateResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates or updates a certificate and associates with key vault secret.")
  @operationId("AppServiceCertificateOrders_UpdateCertificate")
  updateCertificate is ArmCustomPatchSync<
    AppServiceCertificateResource,
    AppServiceCertificatePatchResource
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete the certificate associated with a certificate order.")
  @operationId("AppServiceCertificateOrders_DeleteCertificate")
  deleteCertificate is ArmResourceDeleteSync<AppServiceCertificateResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for List all certificates associated with a certificate order.")
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
