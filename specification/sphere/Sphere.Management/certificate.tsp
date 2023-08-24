import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureSphere;

//Certificates
@doc("An certificate resource belonging to a catalog resource.")
@parentResource(Catalog)
model Certificate is ProxyResource<CertificateProperties> {
  @doc("Serial number of the certificate. Use '.default' to get current active certificate.")
  @key("serialNumber")
  @path
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface Certificates
  extends ProxyResourceOperationsReadList<Certificate, ListQueryParameters> {
  @autoRoute
  @doc("Retrieves cert chain.")
  @armResourceAction(Certificate)
  @post
  retrieveCertChain(
    ...ResourceInstanceParameters<Certificate>,
  ): ArmResponse<CertificateChainResponse> | ErrorResponse;

  @autoRoute
  @armResourceAction(Certificate)
  @post
  @doc("Gets the proof of possession nonce.")
  retrieveProofOfPossessionNonce(
    ...ResourceInstanceParameters<Certificate>,

    @doc("Proof of possession nonce request body ")
    @body
    proofOfPossessionNonceRequest: ProofOfPossessionNonceRequest,
  ): ArmResponse<ProofOfPossessionNonceResponse> | ErrorResponse;
}

@doc("The properties of certificate")
model CertificateProperties {
  @doc("The certificate as a UTF-8 encoded base 64 string.")
  @visibility("read")
  certificate?: string;

  @visibility("read")
  @doc("The certificate status.")
  status?: CertificateStatus;

  @visibility("read")
  @doc("The certificate subject.")
  subject?: string;

  @visibility("read")
  @doc("The certificate thumbprint.")
  thumbprint?: string;

  @visibility("read")
  @doc("The certificate expiry date.")
  expiryUtc?: utcDateTime;

  @visibility("read")
  @doc("The certificate not before date.")
  notBeforeUtc?: utcDateTime;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The certificate chain response.")
model CertificateChainResponse {
  @doc("The certificate chain.")
  @visibility("read")
  certificateChain?: string;
}

@doc("Request for the proof of possession nonce")
model ProofOfPossessionNonceRequest {
  @doc("The proof of possession nonce")
  proofOfPossessionNonce: string;
}

@doc("Result of the action to generate a proof of possession nonce")
model ProofOfPossessionNonceResponse extends CertificateProperties {}
