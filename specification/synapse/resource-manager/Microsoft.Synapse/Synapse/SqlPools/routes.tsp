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

namespace SqlPools;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface WorkspaceManagedSqlServerUsagesOperationGroup {
  /**
   * Get list of server usages metric for workspace managed sql server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get list of usages metric for the server.")
  @operationId("WorkspaceManagedSqlServerUsages_List")
  @autoRoute
  @get
  @action("sqlUsages")
  list is ArmProviderActionSync<
    Response = ServerUsageListResult,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the workspace.
       */
      @path
      @segment("workspaces")
      workspaceName: string;
    }
  >;
}
