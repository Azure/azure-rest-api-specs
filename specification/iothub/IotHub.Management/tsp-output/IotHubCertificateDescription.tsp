import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotHubDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.IotHub;
@doc("The X509 Certificate.")
@parentResource(IotHubDescription)
model IotHubCertificateDescription is ProxyResource<CertificateProperties> {
  @doc("The name of the certificate")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface IotHubCertificateDescriptions {
  @doc("Returns the certificate.")
  get is ArmResourceRead<IotHubCertificateDescription>;
  @doc("Adds new or replaces existing certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    IotHubCertificateDescription,
    {
      ...BaseParameters<IotHubCertificateDescription>;

      @doc("ETag of the Certificate. Do not specify for creating a brand new certificate. Required to update an existing certificate.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes an existing X509 certificate or does nothing if it does not exist.")
  delete is ArmResourceDeleteSync<
    IotHubCertificateDescription,
    {
      ...BaseParameters<IotHubCertificateDescription>;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    }
  >;
  @doc("Returns the list of certificates.")
  listByIotHub is ArmResourceListByParent<IotHubCertificateDescription>;
  @doc("Generates verification code for proof of possession flow. The verification code will be used to generate a leaf certificate.")
  generateVerificationCode is ArmResourceActionSync<
    IotHubCertificateDescription,
    void,
    CertificateWithNonceDescription,
    {
      ...BaseParameters<IotHubCertificateDescription>;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    }
  >;
  @doc("Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.")
  verify is ArmResourceActionSync<
    IotHubCertificateDescription,
    CertificateVerificationDescription,
    IotHubCertificateDescription,
    {
      ...BaseParameters<IotHubCertificateDescription>;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    }
  >;
}
