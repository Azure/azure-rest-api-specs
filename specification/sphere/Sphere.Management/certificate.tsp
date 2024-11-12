import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureSphere;
/**
 * An certificate resource belonging to a catalog resource.
 */
@parentResource(Catalog)
model Certificate is ProxyResource<CertificateProperties> {
  /**
   * Serial number of the certificate. Use '.default' to get current active certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @path
  @key("serialNumber")
  @segment("certificates")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Certificates {
  /**
   * Get a Certificate
   */
  get is ArmResourceRead<Certificate>;

  /**
   * List Certificate resources by Catalog
   */
  listByCatalog is ArmResourceListByParent<
    Certificate,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Certificate>;
      ...CustomFilterQueryParameter;
      ...CustomTopQueryParameter;
      ...CustomSkipQueryParameter;
      ...CustomMaxPageSizeQueryParameter;
    }
  >;

  /**
   * Retrieves cert chain.
   */
  retrieveCertChain is ArmResourceActionSync<
    Certificate,
    void,
    CertificateChainResponse
  >;

  /**
   * Gets the proof of possession nonce.
   */
  retrieveProofOfPossessionNonce is ArmResourceActionSync<
    Certificate,
    ProofOfPossessionNonceRequest,
    ProofOfPossessionNonceResponse
  >;
}

@@doc(Certificates.retrieveProofOfPossessionNonce::parameters.body,
  "Proof of possession nonce request body "
);
@@clientName(Certificates.retrieveProofOfPossessionNonce::parameters.body,
  "proofOfPossessionNonceRequest"
);
