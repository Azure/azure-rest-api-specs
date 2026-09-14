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
@doc("The properties of a production deployment label.")
model DeploymentLabelProperties {
  /** The resource ID of the Function App version to assign to production. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  targetVersionResourceId: string;

  /** Whether the deployment label is managed by the system. */
  @visibility(Lifecycle.Read)
  systemManaged?: true;

  /** The resource ID of the Function App version currently assigned to production. */
  @visibility(Lifecycle.Read)
  activeVersionResourceId?: string;

  /** The status of the resource provisioning operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2026_10_01_preview)
@singleton("production")
@parentResource(Site)
@doc("The system-managed production deployment label.")
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
  /** Gets the production deployment label. */
  get is ArmResourceRead<DeploymentLabel, Error = DefaultErrorResponse>;

  /** Assigns a retained Function App version to production. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The production deployment label is a system-managed singleton assignment and a successful assignment returns 200."
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DeploymentLabel,
    Response = ArmResponse<DeploymentLabel>,
    Error = DefaultErrorResponse
  >;

  /** Clears the production assignment and safely restores legacy serving authority. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Clearing the production assignment completes synchronously with 204 while pod drain continues in the background."
  delete is ArmResourceDeleteSync<
    DeploymentLabel,
    Response = ArmDeletedNoContentResponse,
    Error = DefaultErrorResponse
  >;
}
