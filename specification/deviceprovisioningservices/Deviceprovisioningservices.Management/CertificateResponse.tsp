import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisioningServiceDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The X509 Certificate.
 */
@parentResource(ProvisioningServiceDescription)
model CertificateResponse
  is Azure.ResourceManager.ProxyResource<CertificateProperties> {
  ...ResourceNameParameter<
    Resource = CertificateResponse,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = ""
  >;

  /**
   * The entity tag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface CertificateResponses {
  /**
   * Get the certificate from the provisioning service.
   */
  get is ArmResourceRead<
    CertificateResponse,
    Parameters = {
      /**
       * ETag of the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Add new certificate or update an existing certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CertificateResponse,
    Parameters = {
      /**
       * ETag of the certificate. This is required to update an existing certificate, and ignored while creating a brand new certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<CertificateResponse>,
    Error = ErrorDetails
  >;

  /**
   * Deletes the specified certificate associated with the Provisioning Service
   */
  delete is ArmResourceDeleteSync<
    CertificateResponse,
    Parameters = {
      /**
       * ETag of the certificate
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;

      /**
       * This is optional, and it is the Common Name of the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.name")
      `certificate.name`?: string;

      /**
       * Raw data within the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      /**
       * Indicates if certificate has been verified by owner of the private key.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      /**
       * A description that mentions the purpose of the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      /**
       * Time the certificate is created.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.created")
      `certificate.created`?: utcDateTime;

      /**
       * Time the certificate is last updated.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.lastUpdated")
      `certificate.lastUpdated`?: utcDateTime;

      /**
       * Indicates if the certificate contains a private key.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.nonce")
      `certificate.nonce`?: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Get all the certificates tied to the provisioning service.
   */
  list is ArmResourceListByParent<
    CertificateResponse,
    Response = ArmResponse<CertificateListDescription>,
    Error = ErrorDetails
  >;

  /**
   * Generate verification code for Proof of Possession.
   */
  generateVerificationCode is ArmResourceActionSync<
    CertificateResponse,
    void,
    ArmResponse<VerificationCodeResponse>,
    Parameters = {
      /**
       * ETag of the certificate. This is required to update an existing certificate, and ignored while creating a brand new certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;

      /**
       * Common Name for the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.name")
      `certificate.name`?: string;

      /**
       * Raw data of certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      /**
       * Indicates if the certificate has been verified by owner of the private key.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      /**
       * Description mentioning the purpose of the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      /**
       * Certificate creation time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.created")
      `certificate.created`?: utcDateTime;

      /**
       * Certificate last updated time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.lastUpdated")
      `certificate.lastUpdated`?: utcDateTime;

      /**
       * Indicates if the certificate contains private key.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.nonce")
      `certificate.nonce`?: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.
   */
  @action("verify")
  verifyCertificate is ArmResourceActionSync<
    CertificateResponse,
    VerificationCodeRequest,
    ArmResponse<CertificateResponse>,
    Parameters = {
      /**
       * ETag of the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;

      /**
       * Common Name for the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.name")
      `certificate.name`?: string;

      /**
       * Raw data of certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      /**
       * Indicates if the certificate has been verified by owner of the private key.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      /**
       * Describe the purpose of the certificate.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      /**
       * Certificate creation time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.created")
      `certificate.created`?: utcDateTime;

      /**
       * Certificate last updated time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.lastUpdated")
      `certificate.lastUpdated`?: utcDateTime;

      /**
       * Indicates if the certificate contains private key.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("certificate.nonce")
      `certificate.nonce`?: string;
    },
    Error = ErrorDetails
  >;
}

@@doc(CertificateResponse.name, "Name of the certificate to retrieve.");
@@doc(CertificateResponse.properties, "properties of a certificate");
@@doc(CertificateResponses.createOrUpdate::parameters.resource,
  "The certificate body."
);
@@doc(CertificateResponses.verifyCertificate::parameters.body,
  "The name of the certificate"
);
