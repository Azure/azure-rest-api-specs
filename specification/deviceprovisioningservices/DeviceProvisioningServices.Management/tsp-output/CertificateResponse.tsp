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
@doc("The X509 Certificate.")
@parentResource(ProvisioningServiceDescription)
model CertificateResponse is ProxyResource<CertificateProperties> {
  @doc("Name of the certificate to retrieve.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;

  @doc("The entity tag.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface CertificateResponses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the certificate from the provisioning service.")
  @operationId("DpsCertificate_Get")
  get is ArmResourceRead<
    CertificateResponse,
    {
      ...BaseParameters<CertificateResponse>;

      @doc("ETag of the certificate.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Add new certificate or update an existing certificate.")
  @operationId("DpsCertificate_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CertificateResponse,
    {
      ...BaseParameters<CertificateResponse>;

      @doc("ETag of the certificate. This is required to update an existing certificate, and ignored while creating a brand new certificate.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the specified certificate associated with the Provisioning Service")
  @operationId("DpsCertificate_Delete")
  delete is ArmResourceDeleteSync<
    CertificateResponse,
    {
      ...BaseParameters<CertificateResponse>;

      @doc("ETag of the certificate")
      @header
      `If-Match`: string;

      @doc("This is optional, and it is the Common Name of the certificate.")
      @query("certificateCommonName")
      certificateCommonName?: string;

      @doc("Raw data within the certificate.")
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      @doc("Indicates if certificate has been verified by owner of the private key.")
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      @doc("A description that mentions the purpose of the certificate.")
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      @doc("Time the certificate is created.")
      @query("certificateCreatedOn")
      certificateCreatedOn?: utcDateTime;

      @doc("Time the certificate is last updated.")
      @query("certificateLastUpdatedOn")
      certificateLastUpdatedOn?: utcDateTime;

      @doc("Indicates if the certificate contains a private key.")
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      @doc("Random number generated to indicate Proof of Possession.")
      @query("certificate.nonce")
      `certificate.nonce`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all the certificates tied to the provisioning service.")
  @operationId("DpsCertificate_List")
  list is ArmResourceListByParent<CertificateResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Generate verification code for Proof of Possession.")
  @operationId("DpsCertificate_GenerateVerificationCode")
  generateVerificationCode is ArmResourceActionSync<
    CertificateResponse,
    void,
    VerificationCodeResponse,
    {
      ...BaseParameters<CertificateResponse>;

      @doc("ETag of the certificate. This is required to update an existing certificate, and ignored while creating a brand new certificate.")
      @header
      `If-Match`: string;

      @doc("Common Name for the certificate.")
      @query("certificateCommonName")
      certificateCommonName?: string;

      @doc("Raw data of certificate.")
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      @doc("Indicates if the certificate has been verified by owner of the private key.")
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      @doc("Description mentioning the purpose of the certificate.")
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      @doc("Certificate creation time.")
      @query("certificateCreatedOn")
      certificateCreatedOn?: utcDateTime;

      @doc("Certificate last updated time.")
      @query("certificateLastUpdatedOn")
      certificateLastUpdatedOn?: utcDateTime;

      @doc("Indicates if the certificate contains private key.")
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      @doc("Random number generated to indicate Proof of Possession.")
      @query("certificate.nonce")
      `certificate.nonce`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.")
  @operationId("DpsCertificate_VerifyCertificate")
  verifyCertificate is ArmResourceActionSync<
    CertificateResponse,
    VerificationCodeRequest,
    CertificateResponse,
    {
      ...BaseParameters<CertificateResponse>;

      @doc("ETag of the certificate.")
      @header
      `If-Match`: string;

      @doc("Common Name for the certificate.")
      @query("certificateCommonName")
      certificateCommonName?: string;

      @doc("Raw data of certificate.")
      @query("certificate.rawBytes")
      `certificate.rawBytes`?: bytes;

      @doc("Indicates if the certificate has been verified by owner of the private key.")
      @query("certificate.isVerified")
      `certificate.isVerified`?: boolean;

      @doc("Describe the purpose of the certificate.")
      @query("certificate.purpose")
      `certificate.purpose`?: CertificatePurpose;

      @doc("Certificate creation time.")
      @query("certificateCreatedOn")
      certificateCreatedOn?: utcDateTime;

      @doc("Certificate last updated time.")
      @query("certificateLastUpdatedOn")
      certificateLastUpdatedOn?: utcDateTime;

      @doc("Indicates if the certificate contains private key.")
      @query("certificate.hasPrivateKey")
      `certificate.hasPrivateKey`?: boolean;

      @doc("Random number generated to indicate Proof of Possession.")
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
