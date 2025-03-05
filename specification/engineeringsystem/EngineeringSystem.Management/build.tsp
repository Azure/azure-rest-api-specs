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
model Build is ProxyResource<BuildProperties> {
  ...ResourceNameParameter<Build>;
}

/** The available build types. */
union BuildType {
  /** Azure DevOps pipeline build. */
  AzureDevOps: "AzureDevOps",

  /** Cloud Build. */
  CloudBuild: "CloudBuild",

  /** GitHub build. */
  GitHub: "GitHub",

  string,
}

/** The properties of Build resource. */
model BuildProperties {
  /** The SHA-256 digest is generated from a composite ID that includes the project ID, build definition ID, and build ID. */
  sha256: string;

  /** The organization ID for the build. */
  organizationId?: string;

  /** The project ID for the build. */
  projectId: string;

  /** The build definition ID for the build. */
  buildDefinitionId: string;

  /** The build definition name for the build. */
  buildDefinitionName?: string;

  /** The build ID. */
  buildId: string;

  /** The build type. */
  buildType: BuildType;

  /** The product name for the build. */
  productName?: string;

  /** The product version for the build. */
  productVersion?: string;

  /** The repository ID for the build. */
  repositoryId?: string;

  /** The repository URL for the build. */
  repositoryUrl?: string;

  /** The branch name for the build. */
  branchName?: string;

  /** The date produced for the build. */
  dateProduced?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Builds {
  get is ArmResourceRead<Build>;
  listByParent is ArmResourceListByParent<Build>;
}
