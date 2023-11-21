import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MixedRealityClient;

enum NameUnavailableReason {
  Invalid,
  AlreadyExists,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}
@Azure.Core.fixed
enum SkuTier {
  Free,
  Basic,
  Standard,
  Premium,
}
@Azure.Core.fixed
enum Serial {
  @doc("The Primary Key") Primary: 1,
  @doc("The Secondary Key") Secondary: 2,
}

@doc("""
Result of the request to list Resource Provider operations. It contains a list
of operations and a URL link to get the next set of results.
""")
model OperationPage is Azure.Core.Page<Operation>;

@doc("REST API operation")
model Operation {
  @doc("Operation name: {provider}/{resource}/{operation}")
  name?: string;

  @doc("The object that represents the operation.")
  display?: OperationDisplay;

  @doc("Whether or not this is a data plane operation")
  isDataAction?: boolean;

  @doc("The origin")
  origin?: string;

  @doc("Properties of the operation")
  properties?: OperationProperties;
}

@doc("The object that represents the operation.")
model OperationDisplay {
  @doc("Service provider: Microsoft.ResourceProvider")
  provider: string;

  @doc("Resource on which the operation is performed: Profile, endpoint, etc.")
  resource: string;

  @doc("Operation type: Read, write, delete, etc.")
  operation: string;

  @doc("Description of operation")
  description: string;
}

@doc("Operation properties.")
model OperationProperties {
  @doc("Service specification.")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification payload")
model ServiceSpecification {
  @doc("Specifications of the Log for Azure Monitoring")
  logSpecifications?: LogSpecification[];

  @doc("Specifications of the Metrics for Azure Monitoring")
  metricSpecifications?: MetricSpecification[];
}

@doc("Specifications of the Log for Azure Monitoring")
model LogSpecification {
  @doc("Name of the log")
  name?: string;

  @doc("Localized friendly display name of the log")
  displayName?: string;

  @doc("Blob duration of the log")
  blobDuration?: string;
}

@doc("Specifications of the Metrics for Azure Monitoring")
model MetricSpecification {
  @doc("Name of the metric")
  name?: string;

  @doc("Localized friendly display name of the metric")
  displayName?: string;

  @doc("Localized friendly description of the metric")
  displayDescription?: string;

  @doc("Unit that makes sense for the metric")
  unit?: string;

  @doc("""
Only provide one value for this field. Valid values: Average, Minimum, Maximum,
Total, Count.
""")
  aggregationType?: string;

  @doc("""
Supported aggregation types. Valid values: Average, Minimum, Maximum, Total,
Count.
""")
  supportedAggregationTypes?: string[];

  @doc("""
Supported time grains. Valid values: PT1M, PT5M, PT15M, PT30M, PT1H, PT6H,
PT12H, P1D
""")
  supportedTimeGrainTypes?: string[];

  @doc("Flag to indicate use of regional Mdm accounts")
  enableRegionalMdmAccount?: boolean;

  @doc("Source mdm account")
  sourceMdmAccount?: string;

  @doc("Source mdm namespace")
  sourceMdmNamespace?: string;

  @doc("Metric filter regex pattern")
  metricFilterPattern?: string;

  @doc("""
Flag to determine is Zero is returned for time duration where no metric is
emitted
""")
  fillGapWithZero?: boolean;

  @doc("Metric category")
  category?: string;

  @doc("Internal metric name.")
  internalMetricName?: string;

  @doc("Dimensions of the metric")
  dimensions?: MetricDimension[];

  @doc("Locked aggregation type of the metric")
  lockedAggregationType?: string;
}

@doc("Specifications of the Dimension of metrics")
model MetricDimension {
  @doc("Name of the dimension")
  name?: string;

  @doc("Localized friendly display name of the dimension")
  displayName?: string;

  @doc("Internal name of the dimension.")
  internalName?: string;

  @doc("Flag to indicate export for Shoebox")
  toBeExportedForShoebox?: boolean;
}

@doc("An Error response.")
@error
model CloudError {
  @doc("An Error response.")
  error?: CloudErrorBody;
}

@doc("An error response from Azure.")
model CloudErrorBody {
  @doc("""
An identifier for the error. Codes are invariant and are intended to be
consumed programmatically.
""")
  code?: string;

  @doc("""
A message describing the error, intended to be suitable for displaying in a
user interface.
""")
  message?: string;

  @doc("""
The target of the particular error. For example, the name of the property in
error.
""")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("Check Name Availability Request")
model CheckNameAvailabilityRequest {
  @doc("Resource Name To Verify")
  name: string;

  @doc("Fully qualified resource type which includes provider namespace")
  type: string;
}

@doc("Check Name Availability Response")
model CheckNameAvailabilityResponse {
  @doc("if name Available")
  nameAvailable: boolean;

  @doc("Resource Name To Verify")
  reason?: NameUnavailableReason;

  @doc("detail message")
  message?: string;
}

@doc("""
Result of the request to get resource collection. It contains a list of
resources and a URL link to get the next set of results.
""")
model SpatialAnchorsAccountPage is Azure.Core.Page<SpatialAnchorsAccount>;

@doc("SpatialAnchorsAccount Response.")
model SpatialAnchorsAccount {
  ...TrackedResource;

  @doc("Property bag.")
  properties?: MixedRealityAccountProperties;

  @doc("The identity associated with this account")
  identity?: Identity;

  @doc("The plan associated with this account")
  plan?: Identity;

  @doc("The sku associated with this account")
  sku?: Sku;

  @doc("The kind of account, if supported")
  kind?: Sku;

  @doc("System metadata for this account")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Common Properties shared by Mixed Reality Accounts")
model MixedRealityAccountProperties {
  @doc("The name of the storage account associated with this accountId")
  storageAccountName?: string;

  @doc("unique id of certain account.")
  @visibility("read")
  accountId?: string;

  @doc("Correspond domain name of certain Spatial Anchors Account")
  @visibility("read")
  accountDomain?: string;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: "SystemAssigned";
}

@doc("The resource model definition representing SKU")
model Sku {
  @doc("The name of the SKU. Ex - P3. It is typically a letter+number code")
  name: string;

  @doc("""
This field is required to be implemented by the Resource Provider if the
service has more than one tier, but is not required on a PUT.
""")
  tier?: SkuTier;

  @doc("""
The SKU size. When the name field is the combination of tier and some other
value, this would be the standalone code. 
""")
  size?: string;

  @doc("""
If the service has different generations of hardware, for the same SKU, then
that can be captured here.
""")
  family?: string;

  @doc("""
If the SKU supports scale out/in then the capacity integer should be included.
If scale out/in is not possible for the resource this may be omitted.
""")
  capacity?: int32;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;
}

@doc("Developer Keys of account")
model AccountKeys {
  @doc("value of primary key.")
  @visibility("read")
  primaryKey?: string;

  @doc("value of secondary key.")
  @visibility("read")
  secondaryKey?: string;
}

@doc("Request for account key regeneration")
model AccountKeyRegenerateRequest {
  @doc("Serial of key to be regenerated")
  serial?: Serial;
}

@doc("""
Result of the request to get resource collection. It contains a list of
resources and a URL link to get the next set of results.
""")
model RemoteRenderingAccountPage is Azure.Core.Page<RemoteRenderingAccount>;

@doc("RemoteRenderingAccount Response.")
model RemoteRenderingAccount {
  ...TrackedResource;

  @doc("Property bag.")
  properties?: MixedRealityAccountProperties;

  @doc("The identity associated with this account")
  identity?: Identity;

  @doc("The plan associated with this account")
  plan?: Identity;

  @doc("The sku associated with this account")
  sku?: Sku;

  @doc("The kind of account, if supported")
  kind?: Sku;

  @doc("System metadata for this account")
  @visibility("read")
  systemData?: SystemData;
}

@doc("""
Result of the request to get resource collection. It contains a list of
resources and a URL link to get the next set of results.
""")
model ObjectAnchorsAccountPage is Azure.Core.Page<ObjectAnchorsAccount>;

@doc("ObjectAnchorsAccount Response.")
model ObjectAnchorsAccount {
  ...TrackedResource;
  identity?: ObjectAnchorsAccountIdentity;

  @doc("Property bag.")
  properties?: MixedRealityAccountProperties;

  @doc("The plan associated with this account")
  plan?: Identity;

  @doc("The sku associated with this account")
  sku?: Sku;

  @doc("The kind of account, if supported")
  kind?: Sku;

  @doc("The system metadata related to an object anchors account.")
  @visibility("read")
  systemData?: SystemData;
}

model ObjectAnchorsAccountIdentity {
  ...Identity;
}
