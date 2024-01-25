import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The X509 Certificate.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(IotHubDescription)
@includeInapplicableMetadataInPayload(false)
model CertificateDescription {
  /**
   * The name of the certificate
   */
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  @path
  @key("certificateName")
  @segment("certificates")
  @visibility("read")
  name: string;

  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The entity tag.
   */
  @visibility("read")
  etag?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The description of an X509 CA Certificate.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CertificateProperties;
}

@armResourceOperations
interface CertificateDescriptions {
  /**
   * Returns the certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificates_Get")
  get is ArmResourceRead<CertificateDescription>;

  /**
   * Adds new or replaces existing certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CertificateDescription,
    {
      ...BaseParameters<CertificateDescription>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificates_Delete")
  delete is ArmResourceDeleteSync<
    CertificateDescription,
    {
      ...BaseParameters<CertificateDescription>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificates_ListByIotHub")
  listByIotHub is ArmResourceListByParent<CertificateDescription>;

  /**
   * Generates verification code for proof of possession flow. The verification code will be used to generate a leaf certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificates_GenerateVerificationCode")
  generateVerificationCode is ArmResourceActionSync<
    CertificateDescription,
    void,
    CertificateWithNonceDescription,
    {
      ...BaseParameters<CertificateDescription>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificates_Verify")
  verify is ArmResourceActionSync<
    CertificateDescription,
    CertificateVerificationDescription,
    CertificateDescription,
    {
      ...BaseParameters<CertificateDescription>;

      /**
       * ETag of the Certificate.
       */
      @header
      `If-Match`: string;
    }
  >;
}

@@projectedName(CertificateDescriptions.createOrUpdate::parameters.resource,
  "json",
  "certificateDescription"
);
@@extension(CertificateDescriptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "certificateDescription"
);
@@doc(CertificateDescriptions.createOrUpdate::parameters.resource,
  "The certificate body."
);
@@projectedName(CertificateDescriptions.verify::parameters.body,
  "json",
  "certificateVerificationBody"
);
@@extension(CertificateDescriptions.verify::parameters.body,
  "x-ms-client-name",
  "certificateVerificationBody"
);
@@doc(CertificateDescriptions.verify::parameters.body,
  "The name of the certificate"
);
