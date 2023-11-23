import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Devices;
@doc("The X509 Certificate.")
@parentResource(IotHubDescription)
model CertificateDescription is ProxyResource<CertificateProperties> {
  @doc("The name of the certificate")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface CertificateDescriptions {
  @doc("Returns the certificate.")
  get is ArmResourceRead<CertificateDescription>;
  @doc("Adds new or replaces existing certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CertificateDescription,
    {
      ...BaseParameters<CertificateDescription>;

      @doc("ETag of the Certificate. Do not specify for creating a brand new certificate. Required to update an existing certificate.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes an existing X509 certificate or does nothing if it does not exist.")
  delete is ArmResourceDeleteSync<
    CertificateDescription,
    {
      ...BaseParameters<CertificateDescription>;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    }
  >;
  @doc("Returns the list of certificates.")
  listByIotHub is ArmResourceListByParent<CertificateDescription>;
  @doc("Generates verification code for proof of possession flow. The verification code will be used to generate a leaf certificate.")
  generateVerificationCode is ArmResourceActionSync<
    CertificateDescription,
    {},
    CertificateWithNonceDescription,
    {
      ...BaseParameters<CertificateDescription>;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    }
  >;
  @doc("Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.")
  verify is ArmResourceActionSync<
    CertificateDescription,
    CertificateVerificationDescription,
    CertificateDescription,
    {
      ...BaseParameters<CertificateDescription>;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    }
  >;
}
