import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

interface Operations extends Azure.ResourceManager.Operations {}
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to avoid breaking SDK change"
@@operationId(Operations.list, "Operations_ListAll");

/**
 * Resource identity type.
 */
union ResourceIdentityType {
  string,

  /**
   * No identity.
   */
  None: "None",

  /**
   * System assigned.
   */
  SystemAssigned: "SystemAssigned",

  /**
   * User assigned.
   */
  UserAssigned: "UserAssigned",
}

/**
 * The identity of a resource.
 */
model ResourceIdentity {
  /**
   * String of the resource identity type.
   */
  type: ResourceIdentityType;

  /**
   * The list of user identities associated with the Experiment. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Required to avoid breaking SDK change"
  userAssignedIdentities?: Record<UserAssignedIdentity>;

  /**
   * GUID that represents the principal ID of this resource identity.
   */
  @visibility("read")
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  principalId?: string;

  /**
   * GUID that represents the tenant ID of this resource identity.
   */
  @visibility("read")
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  tenantId?: string;
}

alias ParentResourceParameters = {
  /**
   * The parent resource provider namespace.
   */
  @path
  @segment("providers")
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  parentProviderNamespace: string;

  /**
   * The parent resource type.
   */
  @path
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  parentResourceType: string;

  /**
   * The parent resource name.
   */
  @path
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  parentResourceName: string;
};

/**
 * Current provisioning state for a given Azure Chaos resource.
 */
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  /**
   * Initial creation in progress.
   */
  Creating: "Creating",

  /**
   * Update in progress.
   */
  Updating: "Updating",

  /**
   * Deletion in progress.
   */
  Deleting: "Deleting",
}

/**
 * Enum of the selector type.
 */
union SelectorType {
  string,

  /**
   * List selector type.
   */
  List: "List",

  /**
   * Query selector type.
   */
  Query: "Query",
}

/**
 * Enum that discriminates between filter types. Currently only `Simple` type is supported.
 */
union FilterType {
  string,

  /**
   * Simple filter type.
   */
  Simple: "Simple",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,

  /**
   * Pending status.
   */
  Pending: "Pending",

  /**
   * Approved status.
   */
  Approved: "Approved",

  /**
   * Rejected status.
   */
  Rejected: "Rejected",
}

/**
 * Public Network Access Control for PrivateAccess resource.
 */
union PublicNetworkAccessOption {
  string,

  /**
   * Enabled access.
   */
  Enabled: "Enabled",

  /**
   * Disabled access.
   */
  Disabled: "Disabled",
}

/**
 * Enum of the Target reference type.
 */
union TargetReferenceType {
  string,

  /**
   * Chaos target reference type.
   */
  ChaosTarget: "ChaosTarget",
}

/**
 * Enum union of Chaos experiment action types.
 */
union ExperimentActionType {
  string,
  delay: "delay",
  discrete: "discrete",
  continuous: "continuous",
}

/**
 * Model that represents a list of Capability resources and a link for pagination.
 */
model CapabilityListResult is Azure.Core.Page<Capability>;

/**
 * Model that represents the Capability properties model.
 */
model CapabilityProperties {
  /**
   * String of the Publisher that this Capability extends.
   */
  @visibility("read")
  publisher?: string;

  /**
   * String of the Target Type that this Capability extends.
   */
  @visibility("read")
  targetType?: string;

  /**
   * Localized string of the description.
   */
  @visibility("read")
  description?: string;

  /**
   * URL to retrieve JSON schema of the Capability parameters.
   */
  @visibility("read")
  @maxLength(2048)
  parametersSchema?: string;

  /**
   * String of the URN for this Capability Type.
   */
  @visibility("read")
  @maxLength(2048)
  urn?: string;

  /**
   * Resource provisioning state. Not currently in use because resource is created synchronously.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Model that represents a list of Capability Type resources and a link for pagination.
 */
model CapabilityTypeListResult is Azure.Core.Page<CapabilityType>;

/**
 * Model that represents the Capability Type properties model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
model CapabilityTypeProperties {
  /**
   * String of the Publisher that this Capability Type extends.
   */
  @visibility("read")
  publisher?: string;

  /**
   * String of the Target Type that this Capability Type extends.
   */
  @visibility("read")
  targetType?: string;

  /**
   * Localized string of the display name.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Localized string of the description.
   */
  @visibility("read")
  description?: string;

  /**
   * URL to retrieve JSON schema of the Capability Type parameters.
   */
  @visibility("read")
  @maxLength(2048)
  parametersSchema?: string;

  /**
   * String of the URN for this Capability Type.
   */
  @visibility("read")
  @maxLength(2048)
  urn?: string;

  /**
   * String of the kind of this Capability Type.
   */
  @visibility("read")
  kind?: string;

  /**
   * Control plane actions necessary to execute capability type.
   */
  @visibility("read")
  azureRbacActions?: string[];

  /**
   * Data plane actions necessary to execute capability type.
   */
  @visibility("read")
  azureRbacDataActions?: string[];

  /**
   * Runtime properties of this Capability Type.
   */
  @visibility("read")
  runtimeProperties?: CapabilityTypePropertiesRuntimeProperties;
}

/**
 * Runtime properties of this Capability Type.
 */
model CapabilityTypePropertiesRuntimeProperties {
  /**
   * String of the kind of the resource's action type (continuous or discrete).
   */
  @visibility("read")
  kind?: string;
}

/**
 * Model that represents a list of Experiment resources and a link for pagination.
 */
model ExperimentListResult is Azure.Core.Page<Experiment>;

/**
 * Model that represents the Experiment properties model.
 */
model ExperimentProperties {
  /**
   * Most recent provisioning state for the given experiment resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * List of steps.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  steps: ChaosExperimentStep[];

  /**
   * List of selectors.
   */
  selectors: ChaosTargetSelector[];

  /**
   * Optional customer-managed Storage account where Experiment schema will be stored.
   */
  customerDataStorage?: CustomerDataStorageProperties;
}

/**
 * Model that represents a step in the Experiment resource.
 */
model ChaosExperimentStep {
  /**
   * String of the step name.
   */
  @minLength(1)
  name: string;

  /**
   * List of branches.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  branches: ChaosExperimentBranch[];
}

/**
 * Model that represents a branch in the step. 9 total per experiment.
 */
model ChaosExperimentBranch {
  /**
   * String of the branch name.
   */
  @minLength(1)
  name: string;

  /**
   * List of actions.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  actions: ChaosExperimentAction[];
}

/**
 * Model that represents the base action model. 9 total per experiment.
 */
@discriminator("type")
model ChaosExperimentAction {
  /**
   * String that represents a Capability URN.
   */
  @maxLength(2048)
  name: string;

  /**
   * Chaos experiment action discriminator type
   */
  type: ExperimentActionType;
}

/**
 * Model that represents a selector in the Experiment resource.
 */
@discriminator("type")
model ChaosTargetSelector {
  /**
   * String of the selector ID.
   */
  @minLength(1)
  id: string;

  /**
   * Chaos target selector discriminator type
   */
  type: SelectorType;

  /**
   * Model that represents available filter types that can be applied to a targets list.
   */
  filter?: ChaosTargetFilter;
}

/**
 * Model that represents available filter types that can be applied to a targets list.
 */
@discriminator("type")
model ChaosTargetFilter {
  /**
   * Chaos target filter discriminator type
   */
  type: FilterType;
}

/**
 * Model that represents the Customer Managed Storage for an Experiment.
 */
model CustomerDataStorageProperties {
  /**
   * ARM Resource ID of the Storage account to use for Customer Data storage.
   */
  storageAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * Name of the Azure Blob Storage container to use or create.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z0-9]([a-z0-9]|(-(?!-))){1,61}[a-z0-9]$")
  blobContainerName?: string;
}

/**
 * Describes an experiment update.
 */
model ExperimentUpdate {
  /**
   * The identity of the experiment resource.
   */
  identity?: ResourceIdentity;

  /**
   * Experiment tags.
   */
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<Experiment>;
}

/**
 * Model that represents a list of Experiment executions and a link for pagination.
 */
model ExperimentExecutionListResult is Azure.Core.Page<ExperimentExecution>;

/**
 * Model that represents the execution properties of an Experiment.
 */
model ExperimentExecutionProperties {
  /**
   * The status of the execution.
   */
  @visibility("read")
  status?: string;

  /**
   * String that represents the start date time.
   */
  @visibility("read")
  startedAt?: utcDateTime;

  /**
   * String that represents the stop date time.
   */
  @visibility("read")
  stoppedAt?: utcDateTime;

  /**
   * Resource provisioning state. Not currently in use for executions.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Model that represents the execution details of an Experiment.
 */
model ExperimentExecutionDetails {
  /**
   * String of the resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * String of the fully qualified resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * String of the resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * The properties of the experiment execution details.
   */
  @visibility("read")
  properties?: ExperimentExecutionDetailsProperties;
}

/**
 * Model that represents the extended properties of an experiment execution.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ExperimentExecutionDetailsProperties
  extends ExperimentExecutionProperties {
  /**
   * The reason why the execution failed.
   */
  @visibility("read")
  failureReason?: string;

  /**
   * String that represents the last action date time.
   */
  @visibility("read")
  lastActionAt?: utcDateTime;

  /**
   * The information of the experiment run.
   */
  @visibility("read")
  runInformation?: ExperimentExecutionDetailsPropertiesRunInformation;
}

/**
 * The information of the experiment run.
 */
model ExperimentExecutionDetailsPropertiesRunInformation {
  /**
   * The steps of the experiment run.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["stepName"])
  steps?: StepStatus[];
}

/**
 * Model that represents the a list of branches and branch statuses.
 */
model StepStatus {
  /**
   * The name of the step.
   */
  @visibility("read")
  stepName?: string;

  /**
   * The id of the step.
   */
  @visibility("read")
  stepId?: string;

  /**
   * The value of the status of the step.
   */
  @visibility("read")
  status?: string;

  /**
   * The array of branches.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["branchName"])
  branches?: BranchStatus[];
}

/**
 * Model that represents the a list of actions and action statuses.
 */
model BranchStatus {
  /**
   * The name of the branch status.
   */
  @visibility("read")
  branchName?: string;

  /**
   * The id of the branch status.
   */
  @visibility("read")
  branchId?: string;

  /**
   * The status of the branch.
   */
  @visibility("read")
  status?: string;

  /**
   * The array of actions.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["actionId"])
  actions?: ActionStatus[];
}

/**
 * Model that represents the an action and its status.
 */
model ActionStatus {
  /**
   * The name of the action status.
   */
  @visibility("read")
  actionName?: string;

  /**
   * The id of the action status.
   */
  @visibility("read")
  actionId?: string;

  /**
   * The status of the action.
   */
  @visibility("read")
  status?: string;

  /**
   * String that represents the start time of the action.
   */
  @visibility("read")
  startTime?: utcDateTime;

  /**
   * String that represents the end time of the action.
   */
  @visibility("read")
  endTime?: utcDateTime;

  /**
   * The array of targets.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  targets?: ExperimentExecutionActionTargetDetailsProperties[];
}

/**
 * Model that represents the Experiment action target details properties model.
 */
model ExperimentExecutionActionTargetDetailsProperties {
  /**
   * The status of the execution.
   */
  @visibility("read")
  status?: string;

  /**
   * The target for the action.
   */
  @visibility("read")
  target?: string;

  /**
   * String that represents the failed date time.
   */
  @visibility("read")
  targetFailedTime?: utcDateTime;

  /**
   * String that represents the completed date time.
   */
  @visibility("read")
  targetCompletedTime?: utcDateTime;

  /**
   * The error of the action.
   */
  @visibility("read")
  error?: ExperimentExecutionActionTargetDetailsError;
}

/**
 * Model that represents the Experiment action target details error model.
 */
model ExperimentExecutionActionTargetDetailsError {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message
   */
  @visibility("read")
  message?: string;
}

/**
 * The status of operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OperationStatus extends ErrorResponse {
  /**
   * The operation Id.
   */
  id?: string;

  /**
   * The operation name.
   */
  name?: string;

  /**
   * The start time of the operation.
   */
  @visibility("read")
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  @visibility("read")
  endTime?: utcDateTime;

  /**
   * The status of the operation.
   */
  status?: string;
}

/**
 * Model that represents a list of private access resources and a link for pagination.
 */
model PrivateAccessListResult is Azure.Core.Page<PrivateAccess>;

/**
 * The properties of a private access resource
 */
model PrivateAccessProperties {
  /**
   * Most recent provisioning state for the given privateAccess resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * A readonly collection of private endpoint connection. Currently only one endpoint connection is supported.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Public Network Access Control for PrivateAccess resource.
   */
  publicNetworkAccess?: PublicNetworkAccessOption;
}

/**
 * Properties of the private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility("read")
  groupIds?: string[];

  /**
   * The private endpoint resource.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The private endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for private endpoint.
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Describes a private access update.
 */
model PrivateAccessPatch {
  /**
   * The tags of the private access resource.
   */
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<PrivateAccess>;
}

/**
 * A list of private link resources
 */
model PrivateEndpointConnectionListResult
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult is Azure.Core.Page<PrivateLinkResource>;

/**
 * A private link resource.
 */
model PrivateLinkResource
  is Azure.ResourceManager.TrackedResource<
    PrivateLinkResourceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = Experiment,
    KeyName = "experimentName",
    SegmentName = "experiments",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource private link DNS zone name.
   */
  requiredZoneNames?: string[];

  /**
   * Resource provisioning state. Not currently in use.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Model that represents a list of Target Type resources and a link for pagination.
 */
model TargetTypeListResult is Azure.Core.Page<TargetType>;

/**
 * Model that represents the base Target Type properties model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
model TargetTypeProperties {
  /**
   * Localized string of the display name.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Localized string of the description.
   */
  @visibility("read")
  description?: string;

  /**
   * URL to retrieve JSON schema of the Target Type properties.
   */
  @visibility("read")
  @maxLength(2048)
  propertiesSchema?: string;

  /**
   * List of resource types this Target Type can extend.
   */
  @visibility("read")
  resourceTypes?: string[];
}

/**
 * Model that represents a list of Target resources and a link for pagination.
 */
model TargetListResult is Azure.Core.Page<Target>;

/**
 * Model that represents a continuous action.
 */
model ContinuousAction extends ChaosExperimentAction {
  /**
   * ISO8601 formatted string that represents a duration.
   */
  duration: duration;

  /**
   * List of key value pairs.
   */
  @OpenAPI.extension("x-ms-identifiers", ["key"])
  parameters: KeyValuePair[];

  /**
   * String that represents a selector.
   */
  @minLength(1)
  selectorId: string;

  /**
   * Enum that discriminates between action models.
   */
  type: "continuous";
}

/**
 * A map to describe the settings of an action.
 */
model KeyValuePair {
  /**
   * The name of the setting for the action.
   */
  @minLength(1)
  key: string;

  /**
   * The value of the setting for the action.
   */
  @minLength(1)
  value: string;
}

/**
 * Model that represents a delay action.
 */
model DelayAction extends ChaosExperimentAction {
  /**
   * ISO8601 formatted string that represents a duration.
   */
  duration: duration;

  /**
   * Enum that discriminates between action models.
   */
  type: "delay";
}

/**
 * Model that represents a discrete action.
 */
model DiscreteAction extends ChaosExperimentAction {
  /**
   * List of key value pairs.
   */
  @OpenAPI.extension("x-ms-identifiers", ["key"])
  parameters: KeyValuePair[];

  /**
   * String that represents a selector.
   */
  @minLength(1)
  selectorId: string;

  /**
   * Enum that discriminates between action models.
   */
  type: "discrete";
}

/**
 * Model that represents a list selector.
 */
model ChaosTargetListSelector extends ChaosTargetSelector {
  /**
   * List of Target references.
   */
  targets: TargetReference[];

  /**
   * Enum of the selector type.
   */
  type: "List";
}

/**
 * Model that represents a reference to a Target in the selector.
 */
model TargetReference {
  /**
   * Enum of the Target reference type.
   */
  type: TargetReferenceType;

  /**
   * String of the resource ID of a Target resource.
   */
  @pattern("^\\/[Ss][Uu][Bb][Ss][Cc][Rr][Ii][Pp][Tt][Ii][Oo][Nn][Ss]\\/[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\\/[Rr][Ee][Ss][Oo][Uu][Rr][Cc][Ee][Gg][Rr][Oo][Uu][Pp][Ss]\\/[a-zA-Z0-9_\\-\\.\\(\\)]*[a-zA-Z0-9_\\-\\(\\)]\\/[Pp][Rr][Oo][Vv][Ii][Dd][Ee][Rr][Ss]\\/[a-zA-Z0-9]+\\.[a-zA-Z0-9]+\\/[a-zA-Z0-9_\\-\\.]+\\/[a-zA-Z0-9_\\-\\.]+\\/[Pp][Rr][Oo][Vv][Ii][Dd][Ee][Rr][Ss]\\/[Mm][Ii][Cc][Rr][Oo][Ss][Oo][Ff][Tt]\\.[Cc][Hh][Aa][Oo][Ss]\\/[Tt][Aa][Rr][Gg][Ee][Tt][Ss]\\/[a-zA-Z0-9_\\-\\.]+$")
  id: string;
}

/**
 * Model that represents a query selector.
 */
model ChaosTargetQuerySelector extends ChaosTargetSelector {
  /**
   * Azure Resource Graph (ARG) Query Language query for target resources.
   */
  queryString: string;

  /**
   * Subscription id list to scope resource query.
   */
  subscriptionIds: string[];

  /**
   * Enum of the selector type.
   */
  type: "Query";
}

/**
 * Model that represents a simple target filter.
 */
model ChaosTargetSimpleFilter extends ChaosTargetFilter {
  /**
   * Model that represents the Simple filter parameters.
   */
  parameters?: ChaosTargetSimpleFilterParameters;

  /**
   * Enum that discriminates between filter types. Currently only `Simple` type is supported.
   */
  type: "Simple";
}

/**
 * Model that represents the Simple filter parameters.
 */
model ChaosTargetSimpleFilterParameters {
  /**
   * List of Azure availability zones to filter targets by.
   */
  zones?: string[];
}
