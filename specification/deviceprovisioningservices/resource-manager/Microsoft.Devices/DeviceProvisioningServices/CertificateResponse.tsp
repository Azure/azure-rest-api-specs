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

alias CertificateNameQuery1 = {
  /**
   * Common Name for the certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query("certificate.name")
  `certificate.name`?: string;
};

alias CertificateNameQuery2 = {
  /**
   * This is optional, and it is the Common Name of the certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing CertificateNameQuery2.certificate.name retains the certificate.name query parameter; preserve wire compatibility."
  @query("certificate.name")
  `certificate.name`?: string;
};

alias CertificateNameQuery3 = {
  /**
   * Time the certificate is created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing CertificateNameQuery3.certificateCreated retains the certificate.created query parameter; preserve wire compatibility."
  @query("certificate.created")
  certificateCreated?: utcDateTime;
};

alias CertificateNameQuery4 = {
  /**
   * Certificate last updated time.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing CertificateNameQuery4.certificateLastUpdated retains the certificate.lastUpdated query parameter; preserve wire compatibility."
  @query("certificate.lastUpdated")
  certificateLastUpdated?: utcDateTime;
};

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
      @header("If-Match")
      ifMatch?: string;
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
      @header("If-Match")
      ifMatch?: string;
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
      @header("If-Match")
      ifMatch: string;

      ...CertificateNameQuery2;

      /**
       * Raw data within the certificate.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing delete.certificateRawBytes retains the certificate.rawBytes query parameter; preserve wire compatibility."
      @query("certificate.rawBytes")
      certificateRawBytes?: bytes;

      /**
       * Indicates if certificate has been verified by owner of the private key.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing delete.certificateIsVerified retains the certificate.isVerified query parameter; preserve wire compatibility."
      @query("certificate.isVerified")
      certificateIsVerified?: boolean;

      /**
       * A description that mentions the purpose of the certificate.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing delete.certificatePurpose retains the certificate.purpose query parameter; preserve wire compatibility."
      @query("certificate.purpose")
      certificatePurpose?: CertificatePurpose;

      ...CertificateNameQuery3;
      ...CertificateNameQuery4;

      /**
       * Indicates if the certificate contains a private key.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing delete.certificateHasPrivateKey retains the certificate.hasPrivateKey query parameter; preserve wire compatibility."
      @query("certificate.hasPrivateKey")
      certificateHasPrivateKey?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing delete.certificateNonce retains the certificate.nonce query parameter; preserve wire compatibility."
      @query("certificate.nonce")
      certificateNonce?: string;
    },
    Error = ErrorDetails
  >;

  /**
   * Get all the certificates tied to the provisioning service.
   */
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
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
      @header("If-Match")
      ifMatch: string;

      ...CertificateNameQuery1;

      /**
       * Raw data of certificate.
       */
      @query("certificate.rawBytes")
      certificateRawBytes?: bytes;

      /**
       * Indicates if the certificate has been verified by owner of the private key.
       */
      @query("certificate.isVerified")
      certificateIsVerified?: boolean;

      /**
       * Description mentioning the purpose of the certificate.
       */
      @query("certificate.purpose")
      certificatePurpose?: CertificatePurpose;

      ...CertificateNameQuery3;
      ...CertificateNameQuery4;

      /**
       * Indicates if the certificate contains private key.
       */
      @query("certificate.hasPrivateKey")
      certificateHasPrivateKey?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      @query("certificate.nonce")
      certificateNonce?: string;
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
      @header("If-Match")
      ifMatch: string;

      ...CertificateNameQuery1;

      /**
       * Raw data of certificate.
       */
      @query("certificate.rawBytes")
      certificateRawBytes?: bytes;

      /**
       * Indicates if the certificate has been verified by owner of the private key.
       */
      @query("certificate.isVerified")
      certificateIsVerified?: boolean;

      /**
       * Describe the purpose of the certificate.
       */
      @query("certificate.purpose")
      certificatePurpose?: CertificatePurpose;

      ...CertificateNameQuery3;
      ...CertificateNameQuery4;

      /**
       * Indicates if the certificate contains private key.
       */
      @query("certificate.hasPrivateKey")
      certificateHasPrivateKey?: boolean;

      /**
       * Random number generated to indicate Proof of Possession.
       */
      @query("certificate.nonce")
      certificateNonce?: string;
    },
    Error = ErrorDetails
  >;
}

@@doc(CertificateResponse.name, "Name of the certificate to retrieve.");
@@doc(CertificateResponse.properties, "properties of a certificate");
@@doc(
  CertificateResponses.createOrUpdate::parameters.resource,
  "The certificate body."
);
@@doc(
  CertificateResponses.verifyCertificate::parameters.body,
  "The name of the certificate"
);
