import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace KustoPools;

/**
 * Path parameters for resources whose parent is a Synapse workspace.
 * The workspace resource itself is defined by the Workspaces project.
 */
alias WorkspaceParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;

  /** The name of the workspace. */
  @segment("workspaces")
  @key
  @path
  workspaceName: string;
};

/** Path parameters for resources whose parent is a Kusto pool. */
alias KustoPoolParentParameters = {
  ...WorkspaceParentParameters;

  /** The name of the Kusto pool. */
  @segment("kustoPools")
  @key
  @path
  kustoPoolName: string;
};

/** Path parameters for resources whose parent is a Kusto pool database. */
alias DatabaseParentParameters = {
  ...KustoPoolParentParameters;

  /** The name of the database in the Kusto pool. */
  @segment("databases")
  @key
  @path
  databaseName: string;
};
