import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;
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
  value?: Azure.ResourceManager.CommonTypes.OperationStatusResult[];

  /**
   * URL to get the next set of Operation Result objects, if any.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}
