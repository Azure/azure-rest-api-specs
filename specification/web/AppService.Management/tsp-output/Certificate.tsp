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

namespace Microsoft.CertificateRegistration;
/**
 * SSL certificate for an app.
 */
model Certificate is TrackedResource<CertificateProperties> {
  /**
   * Name of the certificate.
   */
  @path
  @key("name")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface Certificates {
  /**
   * Description for Get a certificate.
   */
  get is ArmResourceRead<Certificate>;

  /**
   * Description for Create or update a certificate.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Certificate>;

  /**
   * Description for Create or update a certificate.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Certificate, CertificatePatchResource>;

  /**
   * Description for Delete a certificate.
   */
  delete is ArmResourceDeleteSync<Certificate>;

  /**
   * Description for Get all certificates in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificates_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Certificate>;

  /**
   * Description for Get all certificates for a subscription.
   */
  list is ArmListBySubscription<Certificate>;
}

@@projectedName(Certificates.createOrUpdate::parameters.resource,
  "json",
  "certificateEnvelope"
);
@@extension(Certificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "certificateEnvelope"
);
@@doc(Certificates.createOrUpdate::parameters.resource,
  "Details of certificate, if it exists already."
);
@@projectedName(Certificates.update::parameters.properties,
  "json",
  "certificateEnvelope"
);
@@extension(Certificates.update::parameters.properties,
  "x-ms-client-name",
  "certificateEnvelope"
);
@@doc(Certificates.update::parameters.properties,
  "Details of certificate, if it exists already."
);
