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
@doc("The X509 Certificate.")
@parentResource(IotHubDescription)
model CertificateDescription is ProxyResource<CertificateProperties> {
  @doc("The name of the certificate")
  @pattern("^[A-Za-z0-9-._]{1,64}$")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;

  @doc("The entity tag.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface CertificateDescriptions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the certificate.")
  @operationId("Certificates_Get")
  get is ArmResourceRead<CertificateDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Adds new or replaces existing certificate.")
  @operationId("Certificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CertificateDescription,
    {
      ...BaseParameters<CertificateDescription>;

      @doc("ETag of the Certificate. Do not specify for creating a brand new certificate. Required to update an existing certificate.")
      @header
      `If-Match`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing X509 certificate or does nothing if it does not exist.")
  @operationId("Certificates_Delete")
  delete is ArmResourceDeleteSync<
    CertificateDescription,
    {
      ...BaseParameters<CertificateDescription>;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the list of certificates.")
  @operationId("Certificates_ListByIotHub")
  listByIotHub is ArmResourceListByParent<CertificateDescription>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Generates verification code for proof of possession flow. The verification code will be used to generate a leaf certificate.")
  @operationId("Certificates_GenerateVerificationCode")
  generateVerificationCode is ArmResourceActionSync<
    CertificateDescription,
    void,
    CertificateWithNonceDescription,
    {
      ...BaseParameters<CertificateDescription>;

      @doc("ETag of the Certificate.")
      @header
      `If-Match`: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Verifies the certificate's private key possession by providing the leaf cert issued by the verifying pre uploaded certificate.")
  @operationId("Certificates_Verify")
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
