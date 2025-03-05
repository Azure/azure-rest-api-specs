import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SoftwareSupplyChain;

@parentResource(Insight)
model Sbom is ProxyResource<SbomProperties> {
  ...ResourceNameParameter<Sbom, NamePattern = "^[a-zA-Z0-9-.]{3,128}$">;
}

/** The properties of Sbom resource */
model SbomProperties {
  /** The URI of the SBOM. For SPDX SBOMs, this is equivalent to the document namespace */
  uri?: string;

  /** The algorithm used for the SBOM hash */
  algorithm?: string;

  /** The digest of the SBOM */
  digest?: string;

  /** The download location of the SBOM */
  downloadUrl?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Sboms {
  get is ArmResourceRead<Sbom>;
  listByParent is ArmResourceListByParent<Sbom>;
}
