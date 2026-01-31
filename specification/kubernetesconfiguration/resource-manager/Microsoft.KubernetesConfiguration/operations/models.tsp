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
 * Result of the request to list operations.
 */
model ResourceProviderOperationList {
  /**
   * List of operations supported by this resource provider.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  @pageItems
  value: ResourceProviderOperation[];

  /**
   * URL to the next set of results, if any.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * The async operations in progress, in the cluster.
 */
model OperationStatusList is Azure.Core.Page<OperationStatusResult>;

/**
 * The current status of an async operation.
 */
model OperationStatusResult {
  /**
   * Fully qualified ID for the async operation.
   */
  id?: string;

  /**
   * Name of the async operation.
   */
  name?: string;

  /**
   * Operation status.
   */
  status: string;

  /**
   * Additional information, if available.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Record<string> | null;

  /**
   * If present, details of the operation error.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Supported operation of this resource provider.
 */
model ResourceProviderOperation {
  /**
   * Operation name, in format of {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: ResourceProviderOperationDisplay;

  /**
   * The flag that indicates whether the operation applies to data plane.
   */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;

  /**
   * Origin of the operation
   */
  @visibility(Lifecycle.Read)
  origin?: string;
}

/**
 * Display metadata associated with the operation.
 */
model ResourceProviderOperationDisplay {
  /**
   * Resource provider: Microsoft KubernetesConfiguration.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Description of this operation.
   */
  description?: string;
}
