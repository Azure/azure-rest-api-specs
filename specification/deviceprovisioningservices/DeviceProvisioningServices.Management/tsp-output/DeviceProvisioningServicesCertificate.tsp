import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DeviceProvisioningService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DeviceProvisioningServices;
@doc("The X509 Certificate.")
@parentResource(DeviceProvisioningService)
model DeviceProvisioningServicesCertificate
  is ProxyResource<CertificateProperties> {
  @doc("Name of the certificate to retrieve.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface DeviceProvisioningServicesCertificates {
  @doc("Get the certificate from the provisioning service.")
  get is ArmResourceRead<
    DeviceProvisioningServicesCertificate,
    {
      ...BaseParameters<DeviceProvisioningServicesCertificate>;

      @doc("ETag of the certificate.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Add new certificate or update an existing certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DeviceProvisioningServicesCertificate,
    {
      ...BaseParameters<DeviceProvisioningServicesCertificate>;

      @doc("ETag of the certificate. This is required to update an existing certificate, and ignored while creating a brand new certificate.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes the specified certificate associated with the Provisioning Service")
  delete is ArmResourceDeleteSync<
    DeviceProvisioningServicesCertificate,
    {
      ...BaseParameters<DeviceProvisioningServicesCertificate>;

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
  @doc("Get all the certificates tied to the provisioning service.")
  list is ArmResourceListByParent<DeviceProvisioningServicesCertificate>;
  @doc("Generate verification code for Proof of Possession.")
  generateVerificationCode is ArmResourceActionSync<
    DeviceProvisioningServicesCertificate,
    {},
    VerificationCodeResponse,
    {
      ...BaseParameters<DeviceProvisioningServicesCertificate>;

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
  @doc("Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.")
  verifyCertificate is ArmResourceActionSync<
    DeviceProvisioningServicesCertificate,
    VerificationCodeRequest,
    DeviceProvisioningServicesCertificate,
    {
      ...BaseParameters<DeviceProvisioningServicesCertificate>;

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
