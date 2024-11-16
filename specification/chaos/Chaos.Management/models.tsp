import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Chaos;

interface Operations extends Azure.ResourceManager.Operations {}

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
model PostActionResponse {
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
   * Capability resource provisioning state. Not currently implemented.
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
   * Capability type resource provisioning state. Not currently implemented.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

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
  ...Record<unknown>;

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

model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.CommonTypes.ManagedServiceIdentity>>;

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
 * Describes an experiment update.
 */
model ExperimentUpdate {
  /**
   * The tags of the experiment resource.
   */
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  identity?: ManagedServiceIdentityUpdate;
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startedAt?: utcDateTime;

  /**
   * String that represents the stop date time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The status of the operation.
   */
  status?: string;
}

/**
 * Model that represents a list of Target Type resources and a link for pagination.
 */
model TargetTypeListResult is Azure.Core.Page<TargetType>;

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

  /**
   * Target type resource provisioning state. Not currently implemented.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
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
