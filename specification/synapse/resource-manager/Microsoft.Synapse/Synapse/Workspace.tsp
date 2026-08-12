import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A workspace
 */
model Workspace is Azure.ResourceManager.TrackedResource<WorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = ""
  >;

  /**
   * Identity of the workspace
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedIdentity;
}

@armResourceOperations
interface Workspaces {
  /**
   * Gets a workspace
   */
  get is ArmResourceRead<Workspace>;

  /**
   * Creates or updates a workspace
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Workspace,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a workspace
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Workspace,
    PatchModel = WorkspacePatchInfo,
    Response = ArmResponse<Workspace> | ArmResourceCreatedResponse<Workspace>
  >;

  /**
   * Deletes a workspace
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Workspace,
    Response =
      | ArmResponse<Workspace>
      | (ArmDeleteAcceptedLroResponse & {
          @bodyRoot
          _: Workspace;
        })
      | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of workspaces in a resource group
   */
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  /**
   * Returns a list of workspaces in a subscription
   */
  list is ArmListBySubscription<Workspace>;

  /**
   * Replaces firewall rules
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("replaceAllIpFirewallRules")
  @operationId("IpFirewallRules_ReplaceAll")
  replaceAll is ArmResourceActionAsync<
    Workspace,
    ReplaceAllIpFirewallRulesRequest,
    ArmResponse<ReplaceAllFirewallRulesOperationResponse>
  >;

  /**
   * Get list of server usages metric for workspace managed sql server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("sqlUsages")
  @operationId("WorkspaceManagedSqlServerUsages_List")
  workspaceManagedSqlServerUsagesList is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ServerUsageListResult>
  >;
}

@@doc(Workspace.name, "The name of the workspace.");
@@doc(Workspace.properties, "Workspace resource properties");
@@doc(
  Workspaces.createOrUpdate::parameters.resource,
  "Workspace create or update request properties"
);
@@doc(
  Workspaces.update::parameters.properties,
  "Workspace patch request properties"
);
@@doc(
  Workspaces.replaceAll::parameters.body,
  "Replace all IP firewall rules request"
);
