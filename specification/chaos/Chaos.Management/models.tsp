import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Autorest;

namespace Microsoft.Chaos;

interface Operations extends Azure.ResourceManager.Operations {}

alias ParentResourceParameters = {
  @doc("The parent resource provider namespace.")
  @path
  @segment("providers")
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  parentProviderNamespace: string;

  @doc("The parent resource type.")
  @path
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  parentResourceType: string;

  @doc("The parent resource name.")
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

  @doc("Initial creation in progress.")
  Creating: "Creating",

  @doc("Update in progress.")
  Updating: "Updating",

  @doc("Deletion in progress.")
  Deleting: "Deleting",
}

/**
 * Enum of the selector type.
 */
union SelectorType {
  string,
  List: "List",
  Query: "Query",
}

/**
 * Enum that discriminates between filter types. Currently only `Simple` type is supported.
 */
union FilterType {
  string,
  Simple: "Simple",
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
  discrete: "discrete",
  continuous: "continuous",
  delay: "delay",
}

/**
 * Model that represents the post action response.
 */
model PostActionResult {
  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The statusUrl of the post action.
   */
  @visibility("read")
  statusUrl?: string;
}

/**
 * Params model for extension resources
 */
model ExtensionResourcePathParameters {
  @doc("Name of schema group.")
  @path
  subscriptionId: string;

  @doc("Name of schema group.")
  @path
  resourceGroupName: string;

  @doc("Name of schema group.")
  @path
  parentProviderNamespace: string;

  @doc("Name of schema group.")
  @path
  parentResourceType: string;

  @doc("Name of schema group.")
  @path
  parentResourceName: string;
}

/**
 * Model that represents a list of Capability resources and a link for pagination.
 */
model CapabilityListResult is Azure.Core.Page<Capability>;

/**
 * Model that represents the Capability properties model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Currently synchronous-only for PUT/PATCH/DELETE."
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
 * Model that represents a list of Capability Type resources and a link for pagination.
 */
model CapabilityTypeListResult is Azure.Core.Page<CapabilityType>;

/**
 * Model that represents the Capability Type properties model.
 */
/**
 * Model that represents the Capability Type properties model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Resource is not created/modified by user"
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

// #suppress "deprecated" "Workaround for Typespec bug https://github.com/Azure/typespec-azure/issues/383"
// model ManagedServiceIdentityUpdate
//   is OptionalProperties<UpdateableProperties<Azure.ResourceManager.Foundations.ManagedServiceIdentity>>;

/**
 * Describes an experiment update.
 */
model ExperimentUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Resource tags")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("Resource managed identity")
  @visibility("read", "create", "update")
  identity?: Azure.ResourceManager.ManagedServiceIdentityProperty;
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
  @OpenAPI.extension("x-ms-identifiers", ["name"])
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
   * Experiment execution resource provisioning state. Not currently implemented.
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
model ExperimentExecutionDetailsProperties {
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
   * Experiment execution resource provisioning state. Not currently implemented.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

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

// @doc("The current status of an async operation.")
// @resource("operationstatuses")
// @parentResource(ArmLocationResource<"Subscription">)
// model OperationStatus {
//   @doc("Fully qualified ID for the operation status.")
//   @visibility("read")
//   id: string;

//   @doc("The operation id name.")
//   @maxLength(36)
//   @minLength(36)
//   @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
//   @key("operationId")
//   @visibility("read")
//   name: Azure.Core.uuid;

//   @doc("Provisioning state of the resource.")
//   status: Azure.Core.Foundations.OperationState;

//   @doc("The id of the resource.")
//   resourceId?: string;

//   @doc("The start time of the operation, in RFC3339 format.")
//   startTime?: utcDateTime;

//   @doc("The end time of the operation, in RFC3339 format.")
//   endTime?: utcDateTime;

//   #suppress "@azure-tools/typespec-azure-core/no-unknown" "there is no build in type to describe object"
//   @doc("Custom operation properties, populated only for a successful operation.")
//   properties?: unknown;

//   @doc("Operation Error message.")
//   error?: Azure.Core.Foundations.Error;
// }

/**
 * Model that represents a list of Target Type resources and a link for pagination.
 */
model TargetTypeListResult is Azure.Core.Page<TargetType>;

/**
 * Model that represents the base Target Type properties model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource."
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
   * Resource identifier of a Target resource.
   */
  id: Azure.Core.armResourceIdentifier;
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
