import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MixedReality;

/**
 * reason of name unavailable.
 */
union NameUnavailableReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * Serial of key to be regenerated
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Serial {
  /**
   * The Primary Key
   */
  Primary: 1,

  /**
   * The Secondary Key
   */
  Secondary: 2,
}

/**
 * Operation properties.
 */
model OperationProperties {
  /**
   * Service specification.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Azure Monitoring
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  logSpecifications?: LogSpecification[];

  /**
   * Specifications of the Metrics for Azure Monitoring
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  metricSpecifications?: MetricSpecification[];
}

/**
 * Specifications of the Log for Azure Monitoring
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Localized friendly display name of the log
   */
  displayName?: string;

  /**
   * Blob duration of the log
   */
  blobDuration?: string;
}

/**
 * Specifications of the Metrics for Azure Monitoring
 */
model MetricSpecification {
  /**
   * Name of the metric
   */
  name?: string;

  /**
   * Localized friendly display name of the metric
   */
  displayName?: string;

  /**
   * Localized friendly description of the metric
   */
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric
   */
  unit?: string;

  /**
   * Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.
   */
  aggregationType?: string;

  /**
   * Supported aggregation types. Valid values: Average, Minimum, Maximum, Total, Count.
   */
  supportedAggregationTypes?: string[];

  /**
   * Supported time grains. Valid values: PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H, P1D
   */
  supportedTimeGrainTypes?: string[];

  /**
   * Flag to indicate use of regional Mdm accounts
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * Source mdm account
   */
  sourceMdmAccount?: string;

  /**
   * Source mdm namespace
   */
  sourceMdmNamespace?: string;

  /**
   * Metric filter regex pattern
   */
  metricFilterPattern?: string;

  /**
   * Flag to determine is Zero is returned for time duration where no metric is emitted
   */
  fillGapWithZero?: boolean;

  /**
   * Metric category
   */
  category?: string;

  /**
   * Internal metric name.
   */
  internalMetricName?: string;

  /**
   * Dimensions of the metric
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  dimensions?: MetricDimension[];

  /**
   * Locked aggregation type of the metric
   */
  lockedAggregationType?: string;
}

/**
 * Specifications of the Dimension of metrics
 */
model MetricDimension {
  /**
   * Name of the dimension
   */
  name?: string;

  /**
   * Localized friendly display name of the dimension
   */
  displayName?: string;

  /**
   * Internal name of the dimension.
   */
  internalName?: string;

  /**
   * Flag to indicate export for Shoebox
   */
  toBeExportedForShoebox?: boolean;
}

/**
 * An Error response.
 */
@error
model CloudError {
  /**
   * An Error response.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from Azure.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for displaying in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  details?: CloudErrorBody[];
}

/**
 * Check Name Availability Request
 */
model CheckNameAvailabilityRequest {
  /**
   * Resource Name To Verify
   */
  name: string;

  /**
   * Fully qualified resource type which includes provider namespace
   */
  type: string;
}

/**
 * Check Name Availability Response
 */
model CheckNameAvailabilityResponse {
  /**
   * if name Available
   */
  nameAvailable: boolean;

  /**
   * Resource Name To Verify
   */
  reason?: NameUnavailableReason;

  /**
   * detail message
   */
  message?: string;
}

/**
 * Result of the request to get resource collection. It contains a list of resources and a URL link to get the next set of results.
 */
model SpatialAnchorsAccountPage is Azure.Core.Page<SpatialAnchorsAccount>;

/**
 * Common Properties shared by Mixed Reality Accounts
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model MixedRealityAccountProperties {
  /**
   * The name of the storage account associated with this accountId
   */
  storageAccountName?: string;

  /**
   * unique id of certain account.
   */
  @visibility(Lifecycle.Read)
  accountId?: string;

  /**
   * Correspond domain name of certain Spatial Anchors Account
   */
  @visibility(Lifecycle.Read)
  accountDomain?: string;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Developer Keys of account
 */
model AccountKeys {
  /**
   * value of primary key.
   */
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /**
   * value of secondary key.
   */
  @visibility(Lifecycle.Read)
  secondaryKey?: string;
}

/**
 * Request for account key regeneration
 */
model AccountKeyRegenerateRequest {
  /**
   * Serial of key to be regenerated
   */
  serial?: Serial;
}

/**
 * Result of the request to get resource collection. It contains a list of resources and a URL link to get the next set of results.
 */
model RemoteRenderingAccountPage is Azure.Core.Page<RemoteRenderingAccount>;

/**
 * Result of the request to get resource collection. It contains a list of resources and a URL link to get the next set of results.
 */
model ObjectAnchorsAccountPage is Azure.Core.Page<ObjectAnchorsAccount>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ObjectAnchorsAccountIdentity extends Identity {}
