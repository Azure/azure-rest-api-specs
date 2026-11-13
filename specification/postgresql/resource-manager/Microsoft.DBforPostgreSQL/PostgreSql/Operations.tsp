import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Intended executor of the operation.
 */
union OperationOrigin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
}

/**
 * Metric specification for an operation.
 */
model MetricSpecification {
  /**
   * Name of the metric.
   */
  name?: string;

  /**
   * Display name of the metric.
   */
  displayName?: string;

  /**
   * Display description of the metric.
   */
  displayDescription?: string;

  /**
   * Unit of the metric.
   */
  unit?: string;

  /**
   * Aggregation type of the metric.
   */
  aggregationType?: string;

  /**
   * Supported aggregation types for the metric.
   */
  supportedAggregationTypes?: string[];

  /**
   * Supported time grain types for the metric.
   */
  supportedTimeGrainTypes?: string[];

  /**
   * Category of the metric.
   */
  category?: string;
}

/**
 * Log specification for an operation.
 */
model LogSpecification {
  /**
   * Name of the log.
   */
  name?: string;

  /**
   * Display name of the log.
   */
  displayName?: string;

  /**
   * Blob duration for the log.
   */
  blobDuration?: string;
}

/**
 * Service specification for an operation.
 */
model ServiceSpecification {
  /**
   * Metric specifications for the operation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  metricSpecifications?: MetricSpecification[];

  /**
   * Log specifications for the operation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  logSpecifications?: LogSpecification[];
}

/**
 * Additional properties for operation metadata.
 */
model OperationProperties {
  /**
   * Service specification for the operation.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * REST API operation definition.
 */
model Operation {
  /**
   * Name of the operation being performed on this particular object.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Localized display information for this particular operation or action.
   */
  @visibility(Lifecycle.Read)
  display?: OperationDisplay;

  /**
   * Indicates if the operation is a data action.
   */
  isDataAction?: boolean;

  /**
   * Intended executor of the operation.
   */
  @visibility(Lifecycle.Read)
  origin?: OperationOrigin;

  /**
   * Additional descriptions for the operation.
   */
  @visibility(Lifecycle.Read)
  properties?: OperationProperties;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Name of the resource provider.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Type of resource on which the operation is performed.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * Name of the operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

model OperationList is Azure.Core.Page<Operation>;

@@identifiers(OperationList.value, #["name"]);

/**
 * This is the interface that implements the standard Azure Resource Manager operation that returns
 * all supported RP operations. You should have exactly one declaration for each
 * Azure Resource Manager service. It implements
 *   GET "/providers/Microsoft.ContosoProviderHub/operations"
 */
interface Operations
  extends Azure.ResourceManager.Legacy.Operations<
      ArmResponse<OperationList>,
      ErrorResponse
    > {}

@@doc(Operations.list, "Lists all available REST API operations.");
