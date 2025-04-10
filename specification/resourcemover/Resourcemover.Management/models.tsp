import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Migrate;

/**
 * The type of identity used for the resource mover service.
 */
union ResourceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
}

/**
 * Defines the provisioning states.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Defines the MoveType.
 */
union MoveType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RegionToRegion: "RegionToRegion",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RegionToZone: "RegionToZone",
}

/**
 * Defines the move resource input type.
 */
union MoveResourceInputType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MoveResourceId: "MoveResourceId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MoveResourceSourceId: "MoveResourceSourceId",
}

/**
 * Defines the MoveResource states.
 */
union MoveState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AssignmentPending: "AssignmentPending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreparePending: "PreparePending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PrepareInProgress: "PrepareInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PrepareFailed: "PrepareFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MovePending: "MovePending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MoveInProgress: "MoveInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MoveFailed: "MoveFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DiscardInProgress: "DiscardInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DiscardFailed: "DiscardFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CommitPending: "CommitPending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CommitInProgress: "CommitInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CommitFailed: "CommitFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Committed: "Committed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeleteSourcePending: "DeleteSourcePending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceMoveCompleted: "ResourceMoveCompleted",
}

/**
 * Defines the job name.
 */
union JobName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InitialSync: "InitialSync",
}

/**
 * Defines the resolution type.
 */
union ResolutionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Automatic: "Automatic",
}

/**
 * Defines the dependency type.
 */
union DependencyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequiredForPrepare: "RequiredForPrepare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequiredForMove: "RequiredForMove",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union DependencyLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Direct: "Direct",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Descendant: "Descendant",
}

/**
 * Gets or sets the target availability zone.
 */
union TargetAvailabilityZone {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `1`: "1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `2`: "2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `3`: "3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NA: "NA",
}

/**
 * Defines the zone redundant resource setting.
 */
union ZoneRedundant {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enable: "Enable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disable: "Disable",
}

/**
 * Defines the MSI properties of the Move Collection.
 */
model Identity {
  /**
   * The type of identity used for the resource mover service.
   */
  type?: ResourceIdentityType;

  /**
   * Gets or sets the principal id.
   */
  principalId?: string;

  /**
   * Gets or sets the tenant id.
   */
  tenantId?: string;
}

/**
 * Defines the move collection properties.
 */
model MoveCollectionProperties {
  /**
   * Gets or sets the source region.
   */
  sourceRegion?: string;

  /**
   * Gets or sets the target region.
   */
  targetRegion?: string;

  /**
   * Gets or sets the move region which indicates the region where the VM Regional to Zonal move will be conducted.
   */
  moveRegion?: string;

  /**
   * Defines the provisioning states.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the version of move collection.
   */
  version?: string;

  /**
   * Defines the MoveType.
   */
  moveType?: MoveType;

  /**
   * Defines the move collection errors.
   */
  @visibility(Lifecycle.Read)
  errors?: MoveCollectionPropertiesErrors;
}

/**
 * Defines the move collection errors.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MoveCollectionPropertiesErrors extends MoveResourceError {}

/**
 * An error response from the azure resource mover service.
 */
model MoveResourceError {
  /**
   * The move resource error body.
   */
  properties?: MoveResourceErrorBody;
}

/**
 * An error response from the Azure Migrate service.
 */
model MoveResourceErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: MoveResourceErrorBody[];
}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * Cloud error body.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: CloudErrorBody[];
}

/**
 * Defines the request body for updating move collection.
 */
model UpdateMoveCollectionRequest {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Defines the MSI properties of the Move Collection.
   */
  identity?: Identity;
}

/**
 * Operation status REST resource.
 */
model OperationStatus {
  /**
   * Resource Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Operation name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the operation. ARM expects the terminal status to be one of Succeeded/ Failed/ Canceled. All other values imply that the operation is still running.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * End time.
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * Error stating all error details for the operation.
   */
  @visibility(Lifecycle.Read)
  error?: OperationStatusError;

  /**
   * Custom data.
   */
  @visibility(Lifecycle.Read)
  properties?: Record<unknown>;
}

/**
 * Class for operation status errors.
 */
model OperationStatusError {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: OperationStatusError[];

  /**
   * The additional info.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  additionalInfo?: OperationErrorAdditionalInfo[];
}

/**
 * The operation error info.
 */
model OperationErrorAdditionalInfo {
  /**
   * The error type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The operation error info.
   */
  @visibility(Lifecycle.Read)
  info?: MoveErrorInfo;
}

/**
 * The move custom error info.
 */
model MoveErrorInfo {
  /**
   * The affected move resources.
   */
  @visibility(Lifecycle.Read)
  moveResources?: AffectedMoveResource[];
}

/**
 * The RP custom operation error info.
 */
model AffectedMoveResource {
  /**
   * The affected move resource id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The affected move resource source id.
   */
  @visibility(Lifecycle.Read)
  sourceId?: string;

  /**
   * The affected move resources.
   */
  @visibility(Lifecycle.Read)
  moveResources?: AffectedMoveResource[];
}

/**
 * Defines the request body for initiate prepare operation.
 */
model PrepareRequest {
  /**
   * Gets or sets a value indicating whether the operation needs to only run pre-requisite.
   */
  validateOnly?: boolean;

  /**
   * Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.
   */
  moveResources: string[];

  /**
   * Defines the move resource input type.
   */
  moveResourceInputType?: MoveResourceInputType;
}

/**
 * Defines the request body for resource move operation.
 */
model ResourceMoveRequest {
  /**
   * Gets or sets a value indicating whether the operation needs to only run pre-requisite.
   */
  validateOnly?: boolean;

  /**
   * Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.
   */
  moveResources: string[];

  /**
   * Defines the move resource input type.
   */
  moveResourceInputType?: MoveResourceInputType;
}

/**
 * Defines the request body for commit operation.
 */
model CommitRequest {
  /**
   * Gets or sets a value indicating whether the operation needs to only run pre-requisite.
   */
  validateOnly?: boolean;

  /**
   * Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.
   */
  moveResources: string[];

  /**
   * Defines the move resource input type.
   */
  moveResourceInputType?: MoveResourceInputType;
}

/**
 * Defines the request body for discard operation.
 */
model DiscardRequest {
  /**
   * Gets or sets a value indicating whether the operation needs to only run pre-requisite.
   */
  validateOnly?: boolean;

  /**
   * Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.
   */
  moveResources: string[];

  /**
   * Defines the move resource input type.
   */
  moveResourceInputType?: MoveResourceInputType;
}

/**
 * Defines the collection of move resources.
 */
model MoveResourceCollection is Azure.Core.Page<MoveResource> {
  /**
   * Gets or sets the list of summary items and the field on which summary is done.
   */
  summaryCollection?: SummaryCollection;

  /**
   * Gets the total count.
   */
  @visibility(Lifecycle.Read)
  totalCount?: int64;
}

/**
 * Defines the move resource properties.
 */
model MoveResourceProperties {
  /**
   * Defines the provisioning states.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the Source ARM Id of the resource.
   */
  sourceId: string;

  /**
   * Gets or sets the Target ARM Id of the resource.
   */
  @visibility(Lifecycle.Read)
  targetId?: string;

  /**
   * Gets or sets the existing target ARM Id of the resource.
   */
  existingTargetId?: string;

  /**
   * Gets or sets the resource settings.
   */
  resourceSettings?: ResourceSettings;

  /**
   * Gets or sets the source resource settings.
   */
  @visibility(Lifecycle.Read)
  sourceResourceSettings?: ResourceSettings;

  /**
   * Defines the move resource status.
   */
  @visibility(Lifecycle.Read)
  moveStatus?: MoveResourcePropertiesMoveStatus;

  /**
   * Gets or sets the move resource dependencies.
   */
  @visibility(Lifecycle.Read)
  dependsOn?: MoveResourceDependency[];

  /**
   * Gets or sets the move resource dependencies overrides.
   */
  dependsOnOverrides?: MoveResourceDependencyOverride[];

  /**
   * Gets a value indicating whether the resolve action is required over the move collection.
   */
  @visibility(Lifecycle.Read)
  isResolveRequired?: boolean;

  /**
   * Defines the move resource errors.
   */
  @visibility(Lifecycle.Read)
  errors?: MoveResourcePropertiesErrors;
}

/**
 * Gets or sets the resource settings.
 */
@discriminator("resourceType")
model ResourceSettings {
  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceType: string;

  /**
   * Gets or sets the target Resource name.
   */
  targetResourceName?: string;

  /**
   * Gets or sets the target resource group name.
   */
  targetResourceGroupName?: string;
}

/**
 * Defines the move resource status.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MoveResourcePropertiesMoveStatus extends MoveResourceStatus {}

/**
 * Defines the move resource status.
 */
model MoveResourceStatus {
  /**
   * Defines the MoveResource states.
   */
  @visibility(Lifecycle.Read)
  moveState?: MoveState;

  /**
   * Defines the job status.
   */
  jobStatus?: JobStatus;

  /**
   * An error response from the azure resource mover service.
   */
  errors?: MoveResourceError;
}

/**
 * Defines the job status.
 */
model JobStatus {
  /**
   * Defines the job name.
   */
  @visibility(Lifecycle.Read)
  jobName?: JobName;

  /**
   * Gets or sets the monitoring job percentage.
   */
  @visibility(Lifecycle.Read)
  jobProgress?: string;
}

/**
 * Defines the dependency of the move resource.
 */
model MoveResourceDependency {
  /**
   * Gets the source ARM ID of the dependent resource.
   */
  id?: string;

  /**
   * Gets the dependency resolution status.
   */
  resolutionStatus?: string;

  /**
   * Defines the resolution type.
   */
  resolutionType?: ResolutionType;

  /**
   * Defines the dependency type.
   */
  dependencyType?: DependencyType;

  /**
   * Defines the properties for manual resolution.
   */
  manualResolution?: ManualResolutionProperties;

  /**
   * Defines the properties for automatic resolution.
   */
  automaticResolution?: AutomaticResolutionProperties;

  /**
   * Gets or sets a value indicating whether the dependency is optional.
   */
  isOptional?: string;
}

/**
 * Defines the properties for manual resolution.
 */
model ManualResolutionProperties {
  /**
   * Gets or sets the target resource ARM ID of the dependent resource if the resource type is Manual.
   */
  targetId?: string;
}

/**
 * Defines the properties for automatic resolution.
 */
model AutomaticResolutionProperties {
  /**
   * Gets the MoveResource ARM ID of
   * the dependent resource if the resolution type is Automatic.
   */
  moveResourceId?: string;
}

/**
 * Defines the dependency override of the move resource.
 */
model MoveResourceDependencyOverride {
  /**
   * Gets or sets the ARM ID of the dependent resource.
   */
  id?: string;

  /**
   * Gets or sets the resource ARM id of either the MoveResource or the resource ARM ID of
   * the dependent resource.
   */
  targetId?: string;
}

/**
 * Defines the move resource errors.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MoveResourcePropertiesErrors extends MoveResourceError {}

/**
 * Summary Collection.
 */
model SummaryCollection {
  /**
   * Gets or sets the field name on which summary is done.
   */
  fieldName?: string;

  /**
   * Gets or sets the list of summary items.
   */
  @OpenAPI.extension("x-ms-identifiers", #["item"])
  summary?: Summary[];
}

/**
 * Summary item.
 */
model Summary {
  /**
   * Gets the count.
   */
  count?: int32;

  /**
   * Gets the item.
   */
  item?: string;
}

/**
 * Unresolved dependency collection.
 */
model UnresolvedDependencyCollection is Azure.Core.Page<UnresolvedDependency> {
  /**
   * Gets or sets the list of summary items and the field on which summary is done.
   */
  @visibility(Lifecycle.Read)
  summaryCollection?: SummaryCollection;

  /**
   * Gets the total count.
   */
  @visibility(Lifecycle.Read)
  totalCount?: int64;
}

/**
 * Unresolved dependency.
 */
model UnresolvedDependency {
  /**
   * Gets or sets the count.
   */
  count?: int32;

  /**
   * Gets or sets the arm id of the dependency.
   */
  id?: string;
}

/**
 * Defines the request body for bulk remove of move resources operation.
 */
model BulkRemoveRequest {
  /**
   * Gets or sets a value indicating whether the operation needs to only run pre-requisite.
   */
  validateOnly?: boolean;

  /**
   * Gets or sets the list of resource Id's, by default it accepts move resource id's unless the input type is switched via moveResourceInputType property.
   */
  moveResources?: string[];

  /**
   * Defines the move resource input type.
   */
  moveResourceInputType?: MoveResourceInputType;
}

/**
 * Operations discovery class.
 */
model OperationsDiscovery {
  /**
   * Gets or sets Name of the API.
   * The name of the operation being performed on this particular object. It should
   * match the action name that appears in RBAC / the event service.
   * Examples of operations include:
   * * Microsoft.Compute/virtualMachine/capture/action
   * * Microsoft.Compute/virtualMachine/restart/action
   * * Microsoft.Compute/virtualMachine/write
   * * Microsoft.Compute/virtualMachine/read
   * * Microsoft.Compute/virtualMachine/delete
   * Each action should include, in order:
   * (1) Resource Provider Namespace
   * (2) Type hierarchy for which the action applies (e.g. server/databases for a SQL
   * Azure database)
   * (3) Read, Write, Action or Delete indicating which type applies. If it is a PUT/PATCH
   * on a collection or named value, Write should be used.
   * If it is a GET, Read should be used. If it is a DELETE, Delete should be used. If it
   * is a POST, Action should be used.
   * As a note: all resource providers would need to include the "{Resource Provider
   * Namespace}/register/action" operation in their response.
   * This API is used to register for their service, and should include details about the
   * operation (e.g. a localized name for the resource provider + any special
   * considerations like PII release).
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Contains the localized display information for this particular operation / action. These
   * value will be used by several clients for
   * (1) custom role definitions for RBAC;
   * (2) complex query filters for the event service; and
   * (3) audit history / records for management operations.
   */
  display?: Display;

  /**
   * Gets or sets Origin.
   * The intended executor of the operation; governs the display of the operation in the
   * RBAC UX and the audit logs UX.
   * Default value is "user,system".
   */
  origin?: string;

  /**
   * ClientDiscovery properties.
   */
  properties?: Record<unknown>;
}

/**
 * Contains the localized display information for this particular operation / action. These
 * value will be used by several clients for
 * (1) custom role definitions for RBAC;
 * (2) complex query filters for the event service; and
 * (3) audit history / records for management operations.
 */
model Display {
  /**
   * Gets or sets the provider.
   * The localized friendly form of the resource provider name – it is expected to also
   * include the publisher/company responsible.
   * It should use Title Casing and begin with "Microsoft" for 1st party services.
   * e.g. "Microsoft Monitoring Insights" or "Microsoft Compute.".
   */
  provider?: string;

  /**
   * Gets or sets the resource.
   * The localized friendly form of the resource related to this action/operation – it
   * should match the public documentation for the resource provider.
   * It should use Title Casing.
   * This value should be unique for a particular URL type (e.g. nested types should *not*
   * reuse their parent’s display.resource field)
   * e.g. "Virtual Machines" or "Scheduler Job Collections", or "Virtual Machine VM Sizes"
   * or "Scheduler Jobs".
   */
  resource?: string;

  /**
   * Gets or sets the operation.
   * The localized friendly name for the operation, as it should be shown to the user.
   * It should be concise (to fit in drop downs) but clear (i.e. self-documenting).
   * It should use Title Casing.
   * Prescriptive guidance: Read Create or Update Delete 'ActionName'.
   */
  operation?: string;

  /**
   * Gets or sets the description.
   * The localized friendly description for the operation, as it should be shown to the
   * user.
   * It should be thorough, yet concise – it will be used in tool tips and detailed views.
   * Prescriptive guidance for namespace:
   * Read any 'display.provider'  resource
   * Create or Update any  'display.provider'  resource
   * Delete any  'display.provider'  resource
   * Perform any other action on any  'display.provider'  resource
   * Prescriptive guidance for namespace:
   * Read any 'display.resource' Create or Update any  'display.resource' Delete any
   *  'display.resource' 'ActionName' any 'display.resources'.
   */
  description?: string;
}

/**
 * Defines the collection of move collections.
 */
model MoveCollectionResultList is Azure.Core.Page<MoveCollection>;

/**
 * Required for resources collection.
 */
model RequiredForResourcesCollection {
  /**
   * Gets or sets the list of source Ids for which the input resource is required.
   */
  sourceIds?: string[];
}

/**
 * Move resource filter.
 */
model MoveResourceFilter {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: MoveResourceFilterProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model MoveResourceFilterProperties {
  /**
   * The provisioning state.
   */
  provisioningState?: string;
}

/**
 * Unresolved dependencies contract.
 */
model UnresolvedDependenciesFilter {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: UnresolvedDependenciesFilterProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UnresolvedDependenciesFilterProperties {
  /**
   * The count of the resource.
   */
  count?: int32;
}

/**
 * Gets or sets the virtual machine resource settings.
 */
model VirtualMachineResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Gets or sets user-managed identities
   */
  userManagedIdentities?: string[];

  /**
   * Gets or sets the target availability zone.
   */
  targetAvailabilityZone?: TargetAvailabilityZone;

  /**
   * Gets or sets the target virtual machine size.
   */
  targetVmSize?: string;

  /**
   * Gets or sets the target availability set id for virtual machines not in an availability set at source.
   */
  targetAvailabilitySetId?: string;

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Compute/virtualMachines";
}

/**
 * Gets or sets the availability set resource settings.
 */
model AvailabilitySetResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Gets or sets the target fault domain.
   */
  @minValue(1)
  faultDomain?: int32;

  /**
   * Gets or sets the target update domain.
   */
  @maxValue(20)
  @minValue(1)
  updateDomain?: int32;

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Compute/availabilitySets";
}

/**
 * Defines the virtual network subnets resource settings.
 */
model SubnetResourceSettings {
  /**
   * Gets or sets the Subnet name.
   */
  name?: string;

  /**
   * Gets or sets address prefix for the subnet.
   */
  addressPrefix?: string;

  /**
   * Defines reference to NSG.
   */
  networkSecurityGroup?: NsgReference;
}

/**
 * Defines reference to NSG.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NsgReference extends AzureResourceReference {}

/**
 * Defines reference to an Azure resource.
 */
model AzureResourceReference {
  /**
   * Gets the ARM resource ID of the tracked resource being referenced.
   */
  sourceArmResourceId: string;
}

/**
 * Defines the virtual network resource settings.
 */
model VirtualNetworkResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Gets or sets a value indicating whether gets or sets whether the
   * DDOS protection should be switched on.
   */
  enableDdosProtection?: boolean;

  /**
   * Gets or sets the address prefixes for the virtual network.
   */
  addressSpace?: string[];

  /**
   * Gets or sets DHCPOptions that contains an array of DNS servers available to VMs
   * deployed in the virtual network.
   */
  dnsServers?: string[];

  /**
   * Gets or sets List of subnets in a VirtualNetwork.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["/networkSecurityGroup/sourceArmResourceId"]
  )
  subnets?: SubnetResourceSettings[];

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Network/virtualNetworks";
}

/**
 * Defines reference to a proxy resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProxyResourceReference extends AzureResourceReference {
  /**
   * Gets the name of the proxy resource on the target side.
   */
  name?: string;
}

/**
 * Defines the network interface resource settings.
 */
model NetworkInterfaceResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Gets or sets the IP configurations of the NIC.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  ipConfigurations?: NicIpConfigurationResourceSettings[];

  /**
   * Gets or sets a value indicating whether accelerated networking is enabled.
   */
  enableAcceleratedNetworking?: boolean;

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Network/networkInterfaces";
}

/**
 * Defines NIC IP configuration properties.
 */
model NicIpConfigurationResourceSettings {
  /**
   * Gets or sets the IP configuration name.
   */
  name?: string;

  /**
   * Gets or sets the private IP address of the network interface IP Configuration.
   */
  privateIpAddress?: string;

  /**
   * Gets or sets the private IP address allocation method.
   */
  privateIpAllocationMethod?: string;

  /**
   * Defines reference to subnet.
   */
  subnet?: SubnetReference;

  /**
   * Gets or sets a value indicating whether this IP configuration is the primary.
   */
  primary?: boolean;

  /**
   * Gets or sets the references of the load balancer backend address pools.
   */
  @OpenAPI.extension("x-ms-identifiers", #["sourceArmResourceId"])
  loadBalancerBackendAddressPools?: LoadBalancerBackendAddressPoolReference[];

  /**
   * Gets or sets the references of the load balancer NAT rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #["sourceArmResourceId"])
  loadBalancerNatRules?: LoadBalancerNatRuleReference[];

  /**
   * Defines reference to a public IP.
   */
  publicIp?: PublicIpReference;
}

/**
 * Defines reference to subnet.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SubnetReference extends ProxyResourceReference {}

/**
 * Defines reference to load balancer backend address pools.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LoadBalancerBackendAddressPoolReference extends ProxyResourceReference {}

/**
 * Defines reference to load balancer NAT rules.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LoadBalancerNatRuleReference extends ProxyResourceReference {}

/**
 * Defines reference to a public IP.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PublicIpReference extends AzureResourceReference {}

/**
 * Security Rule data model for Network Security Groups.
 */
model NsgSecurityRule {
  /**
   * Gets or sets the Security rule name.
   */
  name?: string;

  /**
   * Gets or sets whether network traffic is allowed or denied.
   * Possible values are “Allow” and “Deny”.
   */
  access?: string;

  /**
   * Gets or sets a description for this rule. Restricted to 140 chars.
   */
  description?: string;

  /**
   * Gets or sets destination address prefix. CIDR or source IP range.
   *  A “*” can also be used to match all source IPs. Default tags such
   * as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used.
   */
  destinationAddressPrefix?: string;

  /**
   * Gets or sets Destination Port or Range. Integer or range between
   * 0 and 65535. A “*” can also be used to match all ports.
   */
  destinationPortRange?: string;

  /**
   * Gets or sets the direction of the rule.InBound or Outbound. The
   * direction specifies if rule will be evaluated on incoming or outgoing traffic.
   */
  direction?: string;

  /**
   * Gets or sets the priority of the rule. The value can be between
   * 100 and 4096. The priority number must be unique for each rule in the collection.
   * The lower the priority number, the higher the priority of the rule.
   */
  priority?: int32;

  /**
   * Gets or sets Network protocol this rule applies to. Can be Tcp, Udp or All(*).
   */
  protocol?: string;

  /**
   * Gets or sets source address prefix. CIDR or source IP range. A
   * “*” can also be used to match all source IPs.  Default tags such as ‘VirtualNetwork’,
   * ‘AzureLoadBalancer’ and ‘Internet’ can also be used. If this is an ingress
   * rule, specifies where network traffic originates from.
   */
  sourceAddressPrefix?: string;

  /**
   * Gets or sets Source Port or Range. Integer or range between 0 and
   * 65535. A “*” can also be used to match all ports.
   */
  sourcePortRange?: string;
}

/**
 * Defines the NSG resource settings.
 */
model NetworkSecurityGroupResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Gets or sets Security rules of network security group.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  securityRules?: NsgSecurityRule[];

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Network/networkSecurityGroups";
}

/**
 * Defines load balancer frontend IP configuration properties.
 */
model LBFrontendIPConfigurationResourceSettings {
  /**
   * Gets or sets the frontend IP configuration name.
   */
  name?: string;

  /**
   * Gets or sets the IP address of the Load Balancer.This is only specified if a specific
   * private IP address shall be allocated from the subnet specified in subnetRef.
   */
  privateIpAddress?: string;

  /**
   * Gets or sets PrivateIP allocation method (Static/Dynamic).
   */
  privateIpAllocationMethod?: string;

  /**
   * Defines reference to subnet.
   */
  subnet?: SubnetReference;

  /**
   * Gets or sets the csv list of zones.
   */
  zones?: string;
}

/**
 * Defines load balancer backend address pool properties.
 */
model LBBackendAddressPoolResourceSettings {
  /**
   * Gets or sets the backend address pool name.
   */
  name?: string;
}

/**
 * Defines the load balancer resource settings.
 */
model LoadBalancerResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Gets or sets load balancer sku (Basic/Standard).
   */
  sku?: string;

  /**
   * Gets or sets the frontend IP configurations of the load balancer.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  frontendIPConfigurations?: LBFrontendIPConfigurationResourceSettings[];

  /**
   * Gets or sets the backend address pools of the load balancer.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  backendAddressPools?: LBBackendAddressPoolResourceSettings[];

  /**
   * Gets or sets the csv list of zones common for all frontend IP configurations. Note this is given
   *  precedence only if frontend IP configurations settings are not present.
   */
  zones?: string;

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Network/loadBalancers";
}

/**
 * Defines the SQL Server resource settings.
 */
model SqlServerResourceSettings extends ResourceSettings {
  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Sql/servers";
}

/**
 * Defines the Sql ElasticPool resource settings.
 */
model SqlElasticPoolResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Defines the zone redundant resource setting.
   */
  zoneRedundant?: ZoneRedundant;

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Sql/servers/elasticPools";
}

/**
 * Defines the Sql Database resource settings.
 */
model SqlDatabaseResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Defines the zone redundant resource setting.
   */
  zoneRedundant?: ZoneRedundant;

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Sql/servers/databases";
}

/**
 * Defines the resource group resource settings.
 */
model ResourceGroupResourceSettings extends ResourceSettings {
  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "resourceGroups";
}

/**
 * Defines the public IP address resource settings.
 */
model PublicIPAddressResourceSettings extends ResourceSettings {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Gets or sets the domain name label.
   */
  domainNameLabel?: string;

  /**
   * Gets or sets the fully qualified domain name.
   */
  fqdn?: string;

  /**
   * Gets or sets public IP allocation method.
   */
  publicIpAllocationMethod?: string;

  /**
   * Gets or sets public IP sku.
   */
  sku?: string;

  /**
   * Gets or sets public IP zones.
   */
  zones?: string;

  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Network/publicIPAddresses";
}

/**
 * Defines the key vault resource settings.
 */
model KeyVaultResourceSettings extends ResourceSettings {
  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.KeyVault/vaults";
}

/**
 * Defines the disk encryption set resource settings.
 */
model DiskEncryptionSetResourceSettings extends ResourceSettings {
  /**
   * The resource type. For example, the value can be Microsoft.Compute/virtualMachines.
   */
  resourceType: "Microsoft.Compute/diskEncryptionSets";
}
