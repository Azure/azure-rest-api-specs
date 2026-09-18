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
@doc("The properties of a Function App label.")
model FunctionAppLabelProperties {
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
@doc("A Function App label. The preview supports only the platform-reserved production Function App label.")
model FunctionAppLabel
  is Azure.ResourceManager.ProxyResource<FunctionAppLabelProperties> {
  ...ResourceNameParameter<
    Resource = FunctionAppLabel,
    KeyName = "labelName",
    SegmentName = "functionAppLabels",
    NamePattern = "^production$"
  >;
}

@added(Versions.v2026_10_01_preview)
@tag("FunctionAppLabels")
@armResourceOperations
@doc("Operations for Function App labels.")
interface FunctionAppLabels {
  /** Gets a Function App label. The preview supports only the production label. */
  get is ArmResourceRead<FunctionAppLabel>;

  /** Assigns a retained Function App version to a Function App label. The preview supports only the production label. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<FunctionAppLabel>;

  /** Lists Function App labels for a site. */
  listBySite is ArmResourceListByParent<FunctionAppLabel>;

  /** Clears a Function App label assignment. Deleting production safely restores legacy serving authority. */
  delete is ArmResourceDeleteSync<FunctionAppLabel>;
}
