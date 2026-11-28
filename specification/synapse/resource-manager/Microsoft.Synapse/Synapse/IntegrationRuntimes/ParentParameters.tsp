import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace IntegrationRuntimes;

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

/** Path parameters for operations whose parent is an integration runtime. */
alias IntegrationRuntimeParentParameters = {
  ...WorkspaceParentParameters;

  /** Integration runtime name */
  @segment("integrationRuntimes")
  @key
  @path
  integrationRuntimeName: string;
};
