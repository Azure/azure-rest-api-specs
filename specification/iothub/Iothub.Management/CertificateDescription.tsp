import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The X509 Certificate.
 */
@parentResource(IotHubDescription)
model CertificateDescription
  is Azure.ResourceManager.ProxyResource<CertificateProperties> {
  ...ResourceNameParameter<
    Resource = CertificateDescription,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = "^[A-Za-z0-9-._]{1,64}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface CertificateDescriptions {
  /**
   * Returns the certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Get")
  get is ArmResourceRead<CertificateDescription>;

  /**
   * Adds new or replaces existing certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CertificateDescription,
    Parameters = {
      /**
       * ETag of the Certificate. Do not specify for creating a brand new certificate. Required to update an existing certificate.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes an existing X509 certificate or does nothing if it does not exist.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Delete")
  delete is ArmResourceDeleteSync<
    CertificateDescription,
    Parameters = {
      /**
       * ETag of the Certificate.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Returns the list of certificates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_ListByIotHub")
  listByIotHub is ArmResourceListByParent<
    CertificateDescription,
    Response = ArmResponse<CertificateListDescription>
  >;

  /**
   * Generates verification code for proof of possession flow. The verification code will be used to generate a leaf certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_GenerateVerificationCode")
  generateVerificationCode is ArmResourceActionSync<
    CertificateDescription,
    void,
    ArmResponse<CertificateWithNonceDescription>,
    Parameters = {
      /**
       * ETag of the Certificate.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Verify")
  verify is ArmResourceActionSync<
    CertificateDescription,
    CertificateVerificationDescription,
    ArmResponse<CertificateDescription>,
    Parameters = {
      /**
       * ETag of the Certificate.
       */
      @header
      `If-Match`: string;
    }
  >;
}

@@doc(CertificateDescription.name, "The name of the certificate");
@@encodedName(CertificateDescription.eTag, "application/json", "etag");
@@doc(CertificateDescription.properties,
  "The description of an X509 CA Certificate."
);
@@doc(CertificateDescriptions.createOrUpdate::parameters.resource,
  "The certificate body."
);
@@doc(CertificateDescriptions.verify::parameters.body,
  "The name of the certificate"
);
