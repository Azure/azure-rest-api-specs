import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./catalog.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
      ...BaseParameters<Certificate>;
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
@@encodedName(Certificates.retrieveProofOfPossessionNonce::parameters.body,
  "application/json",
  "proofOfPossessionNonceRequest"
);
@@extension(Certificates.retrieveProofOfPossessionNonce::parameters.body,
  "x-ms-client-name",
  "proofOfPossessionNonceRequest"
);
