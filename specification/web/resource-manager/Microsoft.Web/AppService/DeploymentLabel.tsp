import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_10_01_preview)
@doc("The properties of a deployment label.")
model DeploymentLabelProperties {
  /** The resource ID of the Function App version to assign to this label. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  targetVersionResourceId: string;

  /** The resource ID of the Function App version currently assigned to this label. */
  @visibility(Lifecycle.Read)
  activeVersionResourceId?: string;

  /** The status of the resource provisioning operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2026_10_01_preview)
@parentResource(Site)
@doc("A deployment label. The preview supports only the system-managed production label.")
model DeploymentLabel
  is Azure.ResourceManager.ProxyResource<DeploymentLabelProperties> {
  ...ResourceNameParameter<
    Resource = DeploymentLabel,
    KeyName = "labelName",
    SegmentName = "deploymentLabels",
    NamePattern = "^production$"
  >;
}

@added(Versions.v2026_10_01_preview)
@tag("DeploymentLabels")
@armResourceOperations
@doc("Operations for deployment labels.")
interface DeploymentLabels {
  /** Gets a deployment label. The preview supports only the production label. */
  get is ArmResourceRead<DeploymentLabel>;

  /** Assigns a retained Function App version to a deployment label. The preview supports only the production label. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DeploymentLabel>;

  /** Lists deployment labels for a site. */
  listBySite is ArmResourceListByParent<DeploymentLabel>;

  /** Clears a deployment label assignment. Deleting production safely restores legacy serving authority. */
  delete is ArmResourceDeleteSync<DeploymentLabel>;
}
