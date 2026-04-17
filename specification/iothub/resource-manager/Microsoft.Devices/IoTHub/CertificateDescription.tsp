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

  /**
   * The entity tag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface CertificateDescriptions {
  /**
   * Returns the certificate.
   */
  @summary("Get the certificate.")
  @tag("Certificates")
  get is ArmResourceRead<CertificateDescription, Error = ErrorDetails>;

  /**
   * Adds new or replaces existing certificate.
   */
  @summary("Upload the certificate to the IoT hub.")
  @tag("Certificates")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CertificateDescription,
    Parameters = {
      /**
       * ETag of the Certificate. Do not specify for creating a brand new certificate. Required to update an existing certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Deletes an existing X509 certificate or does nothing if it does not exist.
   */
  @summary("Delete an X509 certificate.")
  @tag("Certificates")
  delete is ArmResourceDeleteSync<
    CertificateDescription,
    Parameters = {
      /**
       * ETag of the Certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Returns the list of certificates.
   */
  @summary("Get the certificate list.")
  @tag("Certificates")
  listByIotHub is ArmResourceListByParent<
    CertificateDescription,
    Response = ArmResponse<CertificateListDescription>,
    Error = ErrorDetails
  >;

  /**
   * Generates verification code for proof of possession flow. The verification code will be used to generate a leaf certificate.
   */
  @summary("Generate verification code for proof of possession flow.")
  @tag("Certificates")
  generateVerificationCode is ArmResourceActionSync<
    CertificateDescription,
    void,
    ArmResponse<CertificateWithNonceDescription>,
    Parameters = {
      /**
       * ETag of the Certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.
   */
  @summary("Verify certificate's private key possession.")
  @tag("Certificates")
  verify is ArmResourceActionSync<
    CertificateDescription,
    CertificateVerificationDescription,
    ArmResponse<CertificateDescription>,
    Parameters = {
      /**
       * ETag of the Certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Error = ErrorDetails
  >;
}

@@doc(CertificateDescription.name, "The name of the certificate");
@@doc(CertificateDescription.properties,
  "The description of an X509 CA Certificate."
);
@@doc(CertificateDescriptions.createOrUpdate::parameters.resource,
  "The certificate body."
);
@@doc(CertificateDescriptions.verify::parameters.body,
  "The name of the certificate"
);
