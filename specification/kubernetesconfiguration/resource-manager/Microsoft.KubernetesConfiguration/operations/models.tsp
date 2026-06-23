import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KubernetesConfiguration;

/**
 * The async operations in progress, in the cluster.
 */
model OperationStatusList {
  /**
   * List of async operations in progress, in the cluster.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: OperationStatusResult[];

  /**
   * URL to get the next set of Operation Result objects, if any.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

// Using OperationStatusResult from Azure.ResourceManager.CommonTypes v6
// which includes: id, name, status, percentComplete, startTime, endTime, operations, resourceId, error
// Aliases for convenience when referencing common types
alias Operation = Azure.ResourceManager.CommonTypes.Operation;
alias OperationListResult = Azure.ResourceManager.CommonTypes.OperationListResult;
alias OperationStatusResult = Azure.ResourceManager.CommonTypes.OperationStatusResult;
