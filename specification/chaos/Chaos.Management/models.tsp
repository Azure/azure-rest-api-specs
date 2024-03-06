import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Chaos;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Current provisioning state for a given Azure Chaos resource.
 */
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Updating,
  Deleting,
}

/**
 * Enum of the selector type.
 */
enum SelectorType {
  List,
  Query,
}

/**
 * Enum that discriminates between filter types. Currently only `Simple` type is supported.
 */
enum FilterType {
  Simple,
}

/**
 * Enum of the Target reference type.
 */
enum TargetReferenceType {
  ChaosTarget,
}

/**
 * String of the resource identity type.
 */
@fixed
enum ResourceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

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
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * Model that represents the Capability Type properties model.
 */
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
  azureRbacActions?: string[];

  /**
   * Data plane actions necessary to execute capability type.
   */
  azureRbacDataActions?: string[];

  /**
   * Runtime properties of this Capability Type.
   */
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
  steps: ChaosExperimentStep[];

  /**
   * List of selectors.
   */
  selectors: ChaosTargetSelector[];
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
}

/**
 * Model that represents a selector in the Experiment resource.
 */
@discriminator("type")
model ChaosTargetSelector extends Record<unknown> {
  /**
   * String of the selector ID.
   */
  @minLength(1)
  id: string;

  /**
   * Model that represents available filter types that can be applied to a targets list.
   */
  filter?: ChaosTargetFilter;
}

/**
 * Model that represents available filter types that can be applied to a targets list.
 */
@discriminator("type")
model ChaosTargetFilter {}

/**
 * Describes an experiment update.
 */
model ExperimentUpdate {
  /**
   * The identity of the experiment resource.
   */
  identity?: ResourceIdentity;

  /**
   * The tags of the experiment resource.
   */
  tags?: Record<string>;
}

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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedAt?: utcDateTime;

  /**
   * String that represents the stop date time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  stoppedAt?: utcDateTime;
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * String that represents the end time of the action.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The array of targets.
   */
  @visibility("read")
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  targetFailedTime?: utcDateTime;

  /**
   * String that represents the completed date time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
  startTime?: string;

  /**
   * The end time of the operation.
   */
  endTime?: string;

  /**
   * The status of the operation.
   */
  status?: string;
}

/**
 * Model that represents the base Target Type properties model.
 */
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
