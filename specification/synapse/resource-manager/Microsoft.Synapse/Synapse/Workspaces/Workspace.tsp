import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Workspaces;
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

alias WorkspaceRoutedOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    /** The name of the workspace. */
    @path
    @segment("workspaces")
    @key
    workspaceName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
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
    LroHeaders = ArmLroLocationHeader<FinalResult = Workspace> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a workspace
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Workspace,
    PatchModel = WorkspacePatchInfo,
    Response =
      | ArmResponse<Workspace>
      | ArmResourceCreatedResponse<
          Workspace,
          ArmLroLocationHeader<FinalResult = Workspace> &
            Azure.Core.Foundations.RetryAfterHeader
        >
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
   * Get the result of an operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Operations_GetLocationHeaderResult")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/operationResults/{operationId}")
  getLocationHeaderResult is WorkspaceRoutedOps.ActionSync<
    Workspace,
    void,
    OkResponse | CreatedResponse | AcceptedResponse | NoContentResponse,
    Parameters = {
      /**
       * Operation ID
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Get the status of an operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Operations_GetAzureAsyncHeaderResult")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/operationStatuses/{operationId}")
  getAzureAsyncHeaderResult is WorkspaceRoutedOps.ActionSync<
    Workspace,
    void,
    ArmResponse<OperationResource> | NotFoundResponse,
    Parameters = {
      /**
       * Operation ID
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Replaces firewall rules
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IpFirewallRules_ReplaceAll")
  @action("replaceAllIpFirewallRules")
  replaceAll is ArmResourceActionAsync<
    Workspace,
    ReplaceAllIpFirewallRulesRequest,
    ArmResponse<ReplaceAllFirewallRulesOperationResponse>
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
