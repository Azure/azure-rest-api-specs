import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * SSL certificate for an app.
 */
model Certificate
  is Azure.ResourceManager.TrackedResource<CertificateProperties> {
  ...ResourceNameParameter<
    Resource = Certificate,
    KeyName = "name",
    SegmentName = "certificates",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Certificate,
    Response = ArmResourceUpdatedResponse<Certificate>
  >;

  /**
   * Description for Create or update a certificate.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Certificate,
    PatchModel = CertificatePatchResource
  >;

  /**
   * Description for Delete a certificate.
   */
  delete is ArmResourceDeleteSync<Certificate>;

  /**
   * Description for Get all certificates in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Certificate,
    Response = ArmResponse<CertificateCollection>
  >;

  /**
   * Description for Get all certificates for a subscription.
   */
  list is ArmListBySubscription<
    Certificate,
    Parameters = {
      /**
       * Return only information specified in the filter (using OData syntax). For example: $filter=KeyVaultId eq 'KeyVaultId'
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<CertificateCollection>
  >;
}

@@doc(Certificate.name, "Name of the certificate.");
@@doc(Certificate.properties, "Certificate resource specific properties");
@@doc(Certificates.createOrUpdate::parameters.resource,
  "Details of certificate, if it exists already."
);
@@doc(Certificates.update::parameters.properties,
  "Details of certificate, if it exists already."
);
