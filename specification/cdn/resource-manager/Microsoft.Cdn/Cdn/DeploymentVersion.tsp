import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Cdn;
/**
 * Deployment version object
 */
@added(Versions.v2025_09_01_preview)
@parentResource(Profile)
model DeploymentVersion
  is Azure.ResourceManager.ProxyResource<DeploymentVersionProperties> {
  ...ResourceNameParameter<
    Resource = DeploymentVersion,
    KeyName = "versionName",
    SegmentName = "deploymentVersions",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;
}

@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface DeploymentVersions {
  /**
   * Get an existing DeploymentVersion with the specified version name under the specified subscription, resource group and profile.
   */
  get is ArmResourceRead<DeploymentVersion>;

  /**
   * Update an existing DeploymentVersion within a profile.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    DeploymentVersion,
    PatchModel = DeploymentVersionUpdate
  >;

  /**
   * Lists existing deployment versions by profile
   */
  listByProfile is ArmResourceListByParent<DeploymentVersion>;

  /**
   * Approve the deployment of the version
   */
  approve is ArmResourceActionAsync<
    DeploymentVersion,
    void,
    ArmResponse<DeploymentVersion>,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Compare the deployment version to another deployment version
   */
  compare is ArmResourceActionSync<
    DeploymentVersion,
    CompareDeploymentVersionsParameter,
    ArmResponse<CompareDeploymentVersionsResponse>
  >;
}

@@maxLength(DeploymentVersion.name, 260);
@@minLength(DeploymentVersion.name, 1);
@@doc(DeploymentVersion.name,
  "Name of the DeploymentVersion under the profile."
);
@@doc(DeploymentVersion.properties,
  "The JSON object that contains the properties of the deployment version."
);
@@doc(DeploymentVersions.update::parameters.properties,
  "Deployment version properties"
);
@@doc(DeploymentVersions.compare::parameters.body,
  "The deployment version to be compared to"
);
