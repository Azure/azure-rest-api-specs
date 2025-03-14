import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.EngineeringSystem;

@parentResource(Product)
model Sbom is ProxyResource<SbomProperties> {
  ...ResourceNameParameter<Sbom, NamePattern = "^[a-zA-Z0-9-.]{3,128}$">;
}

/** The properties of Sbom resource. */
model SbomProperties {
  /** The URI of the SBOM. For SPDX SBOMs, this is equivalent to the document namespace. */
  uri?: string;

  /** The SHA-256 digest of the SBOM. */
  sha256: string;

  /** The EBOM ID for the SBOM. */
  ebomId?: string;

  /** The product name for the SBOM. */
  productName?: string;

  /** The product version for the SBOM. */
  productVersion?: string;

  /** The product license for the SBOM. */
  license?: string;

  /** The supplier for the SBOM. */
  supplier?: string;

  /** The tool version for the SBOM. */
  toolVersion?: string;

  /** The date produced for the SBOM. */
  dateProduced?: string;

  /** The project ID for the SBOM. */
  projectId?: string;

  /** The build definition ID for the SBOM. */
  buildDefinitionId?: string;

  /** The build definition name for the SBOM. */
  buildDefinitionName?: string;

  /** The branch name of the repository for the SBOM. */
  branchName?: string;

  /** The project ID for the SBOM. */
  repositoryUrl?: string;

  /** The change commit ID of the repository for the SBOM. */
  commit?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Sboms {
  get is ArmResourceRead<Sbom>;
  listByParent is ArmResourceListByParent<Sbom>;
}
