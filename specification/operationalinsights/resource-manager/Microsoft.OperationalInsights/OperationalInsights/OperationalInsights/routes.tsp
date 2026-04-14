// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationStatusesOperationGroup {
  /**
   * Get the status of a long running azure asynchronous operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OperationStatuses_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.OperationalInsights/locations/{location}/operationStatuses/{asyncOperationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * The operation Id.
     */
    @path
    asyncOperationId: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface QueryPacksOperationGroup {
  /**
   * Creates a Log Analytics QueryPack. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("QueryPacks_CreateOrUpdateWithoutName")
  @autoRoute
  @put
  @action("queryPacks")
  createOrUpdateWithoutName is ArmProviderActionSync<
    Request = LogAnalyticsQueryPack,
    Scope = Extension.ResourceGroup,
    Response = ArmCreatedResponse<LogAnalyticsQueryPack>
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface WorkspacesOperationGroup {
  /**
   * Activates failover for the specified workspace.
   *
   * The specified replication location must match the location of the enabled replication for this workspace. The failover operation is asynchronous and can take up to 30 minutes to complete. The status of the operation can be checked using the operationId returned in the response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Workspaces_Failover")
  @autoRoute
  failover is ArmProviderActionAsync<
    Scope = Extension.ResourceGroup,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    Parameters = {
      ...LocationParameter;

      /**
       * The name of the workspace.
       */
      @maxLength(63)
      @minLength(4)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      @segment("workspaces")
      workspaceName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DeletedWorkspacesOperationGroup {
  /**
   * Gets recently deleted workspaces in a subscription, available for recovery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedWorkspaces_List")
  @autoRoute
  @list
  @get
  @action("deletedWorkspaces")
  list is ArmProviderActionSync<
    Response = WorkspaceListResult,
    Scope = SubscriptionActionScope
  >;
  /**
   * Gets recently deleted workspaces in a resource group, available for recovery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedWorkspaces_ListByResourceGroup")
  @autoRoute
  @list
  @get
  @action("deletedWorkspaces")
  listByResourceGroup is ArmProviderActionSync<
    Response = WorkspaceListResult,
    Scope = Extension.ResourceGroup
  >;
}
