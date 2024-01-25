import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisioningServiceDescription.tsp";

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
@parentResource(ProvisioningServiceDescription)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(CertificateProperties)
model CertificateResponse extends ProxyResourceBase {
  /**
   * Name of the certificate to retrieve.
   */
  @path
  @key("certificateName")
  @segment("certificates")
  @visibility("read")
  name: string;

  /**
   * The entity tag.
   */
  @visibility("read")
  etag?: string;

  /**
   * properties of a certificate
   */
  @extension("x-ms-client-flatten", true)
  properties?: CertificateProperties;
}

@armResourceOperations
interface CertificateResponses {
  /**
   * Get the certificate from the provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DpsCertificate_Get")
  get is ArmResourceRead<
    CertificateResponse,
    {
      ...BaseParameters<CertificateResponse>;

      /**
       * ETag of the certificate.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Add new certificate or update an existing certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DpsCertificate_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CertificateResponse,
    {
      ...BaseParameters<CertificateResponse>;

      /**
       * ETag of the certificate. This is required to update an existing certificate, and ignored while creating a brand new certificate.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes the specified certificate associated with the Provisioning Service
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DpsCertificate_Delete")
  delete is ArmResourceDeleteSync<
    CertificateResponse,
    {
      ...BaseParameters<CertificateResponse>;

      /**
       * ETag of the certificate
       */
      @header
      `If-Match`: string;

      /**
       * This is optional, and it is the Common Name of the certificate.
       */
      @query("certificateCommonName")
      certificateCommonName?: string;

      /**
       * Raw data within the certificate.
       */
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      /**
       * Indicates if certificate has been verified by owner of the private key.
       */
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      /**
       * A description that mentions the purpose of the certificate.
       */
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      /**
       * Time the certificate is created.
       */
      @query("certificateCreatedOn")
      certificateCreatedOn?: utcDateTime;

      /**
       * Time the certificate is last updated.
       */
      @query("certificateLastUpdatedOn")
      certificateLastUpdatedOn?: utcDateTime;

      /**
       * Indicates if the certificate contains a private key.
       */
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      @query("certificate.nonce")
      `certificate.nonce`?: string;
    }
  >;

  /**
   * Get all the certificates tied to the provisioning service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DpsCertificate_List")
  list is ArmResourceListByParent<CertificateResponse>;

  /**
   * Generate verification code for Proof of Possession.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DpsCertificate_GenerateVerificationCode")
  generateVerificationCode is ArmResourceActionSync<
    CertificateResponse,
    void,
    VerificationCodeResponse,
    {
      ...BaseParameters<CertificateResponse>;

      /**
       * ETag of the certificate. This is required to update an existing certificate, and ignored while creating a brand new certificate.
       */
      @header
      `If-Match`: string;

      /**
       * Common Name for the certificate.
       */
      @query("certificateCommonName")
      certificateCommonName?: string;

      /**
       * Raw data of certificate.
       */
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      /**
       * Indicates if the certificate has been verified by owner of the private key.
       */
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      /**
       * Description mentioning the purpose of the certificate.
       */
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      /**
       * Certificate creation time.
       */
      @query("certificateCreatedOn")
      certificateCreatedOn?: utcDateTime;

      /**
       * Certificate last updated time.
       */
      @query("certificateLastUpdatedOn")
      certificateLastUpdatedOn?: utcDateTime;

      /**
       * Indicates if the certificate contains private key.
       */
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      @query("certificate.nonce")
      `certificate.nonce`?: string;
    }
  >;

  /**
   * Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DpsCertificate_VerifyCertificate")
  verifyCertificate is ArmResourceActionSync<
    CertificateResponse,
    VerificationCodeRequest,
    CertificateResponse,
    {
      ...BaseParameters<CertificateResponse>;

      /**
       * ETag of the certificate.
       */
      @header
      `If-Match`: string;

      /**
       * Common Name for the certificate.
       */
      @query("certificateCommonName")
      certificateCommonName?: string;

      /**
       * Raw data of certificate.
       */
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      /**
       * Indicates if the certificate has been verified by owner of the private key.
       */
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      /**
       * Describe the purpose of the certificate.
       */
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      /**
       * Certificate creation time.
       */
      @query("certificateCreatedOn")
      certificateCreatedOn?: utcDateTime;

      /**
       * Certificate last updated time.
       */
      @query("certificateLastUpdatedOn")
      certificateLastUpdatedOn?: utcDateTime;

      /**
       * Indicates if the certificate contains private key.
       */
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      @query("certificate.nonce")
      `certificate.nonce`?: string;
    }
  >;
}

@@projectedName(CertificateResponses.createOrUpdate::parameters.resource,
  "json",
  "certificateDescription"
);
@@extension(CertificateResponses.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "certificateDescription"
);
@@doc(CertificateResponses.createOrUpdate::parameters.resource,
  "The certificate body."
);
@@projectedName(CertificateResponses.verifyCertificate::parameters.body,
  "json",
  "request"
);
@@extension(CertificateResponses.verifyCertificate::parameters.body,
  "x-ms-client-name",
  "request"
);
@@doc(CertificateResponses.verifyCertificate::parameters.body,
  "The name of the certificate"
);
