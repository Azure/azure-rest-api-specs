import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.Chaos;

interface Operations extends Azure.ResourceManager.Operations {}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum SelectorType {
  List,
  Query,
}

enum FilterType {
  Simple,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum TargetReferenceType {
  ChaosTarget,
}
@Azure.Core.fixed
enum ResourceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

@doc("Model that represents the Capability properties model.")
model CapabilityProperties {
  @doc("String of the Publisher that this Capability extends.")
  @visibility("read")
  publisher?: string;

  @doc("String of the Target Type that this Capability extends.")
  @visibility("read")
  targetType?: string;

  @doc("Localized string of the description.")
  @visibility("read")
  description?: string;

  @doc("URL to retrieve JSON schema of the Capability parameters.")
  @visibility("read")
  @maxLength(2048)
  parametersSchema?: string;

  @doc("String of the URN for this Capability Type.")
  @visibility("read")
  @maxLength(2048)
  urn?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Model that represents the Capability Type properties model.")
model CapabilityTypeProperties {
  @doc("String of the Publisher that this Capability Type extends.")
  @visibility("read")
  publisher?: string;

  @doc("String of the Target Type that this Capability Type extends.")
  @visibility("read")
  targetType?: string;

  @doc("Localized string of the display name.")
  @visibility("read")
  displayName?: string;

  @doc("Localized string of the description.")
  @visibility("read")
  description?: string;

  @doc("URL to retrieve JSON schema of the Capability Type parameters.")
  @visibility("read")
  @maxLength(2048)
  parametersSchema?: string;

  @doc("String of the URN for this Capability Type.")
  @visibility("read")
  @maxLength(2048)
  urn?: string;

  @doc("String of the kind of this Capability Type.")
  @visibility("read")
  kind?: string;

  @doc("Control plane actions necessary to execute capability type.")
  azureRbacActions?: string[];

  @doc("Data plane actions necessary to execute capability type.")
  azureRbacDataActions?: string[];

  @doc("Runtime properties of this Capability Type.")
  runtimeProperties?: CapabilityTypePropertiesRuntimeProperties;
}

@doc("Runtime properties of this Capability Type.")
model CapabilityTypePropertiesRuntimeProperties {
  @doc("String of the kind of the resource's action type (continuous or discrete).")
  @visibility("read")
  kind?: string;
}

@doc("The identity of a resource.")
model ResourceIdentity {
  @doc("String of the resource identity type.")
  type: ResourceIdentityType;

  @doc("The list of user identities associated with the Experiment. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentities?: Record<UserAssignedIdentity>;

  @doc("GUID that represents the principal ID of this resource identity.")
  @visibility("read")
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  principalId?: string;

  @doc("GUID that represents the tenant ID of this resource identity.")
  @visibility("read")
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  tenantId?: string;
}

@doc("Model that represents the Experiment properties model.")
model ExperimentProperties {
  @doc("List of steps.")
  steps: Step[];

  @doc("List of selectors.")
  selectors: Selector[];

  @doc("A boolean value that indicates if experiment should be started on creation or not.")
  startOnCreation?: boolean;
}

@doc("Model that represents a step in the Experiment resource.")
model Step {
  @doc("String of the step name.")
  @minLength(1)
  name: string;

  @doc("List of branches.")
  branches: Branch[];
}

@doc("Model that represents a branch in the step.")
model Branch {
  @doc("String of the branch name.")
  @minLength(1)
  name: string;

  @doc("List of actions.")
  actions: Action[];
}

@doc("Model that represents the base action model.")
@discriminator("type")
model Action {
  @doc("String that represents a Capability URN.")
  @maxLength(2048)
  name: string;
}

@doc("Model that represents a selector in the Experiment resource.")
@discriminator("type")
model Selector extends Record<unknown> {
  @doc("String of the selector ID.")
  @minLength(1)
  id: string;

  @doc("Model that represents available filter types that can be applied to a targets list.")
  filter?: Filter;
}

@doc("Model that represents available filter types that can be applied to a targets list.")
@discriminator("type")
model Filter {}

@doc("Describes an experiment update.")
model ExperimentUpdate {
  @doc("The identity of the experiment resource.")
  identity?: ResourceIdentity;
}

@doc("Model that represents the result of a cancel Experiment operation.")
model ExperimentCancelOperationResult {
  @doc("String of the Experiment name.")
  @visibility("read")
  name?: string;

  @doc("URL to retrieve the Experiment status.")
  @visibility("read")
  @maxLength(2048)
  statusUrl?: string;
}

@doc("Model that represents the result of a start Experiment operation.")
model ExperimentStartOperationResult {
  @doc("String of the Experiment name.")
  @visibility("read")
  name?: string;

  @doc("URL to retrieve the Experiment status.")
  @visibility("read")
  @maxLength(2048)
  statusUrl?: string;
}

@doc("Model that represents the Experiment status properties model.")
model ExperimentStatusProperties {
  @doc("String that represents the status of a Experiment.")
  @visibility("read")
  status?: string;

  @doc("String that represents the created date time of a Experiment.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateUtc?: utcDateTime;

  @doc("String that represents the end date time of a Experiment.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateUtc?: utcDateTime;
}

@doc("Model that represents the Experiment execution details properties model.")
model ExperimentExecutionDetailsProperties {
  @doc("The id of the experiment.")
  @visibility("read")
  experimentId?: string;

  @doc("The value of the status of the experiment execution.")
  @visibility("read")
  status?: string;

  @doc("The reason why the execution failed.")
  @visibility("read")
  failureReason?: string;

  @doc("String that represents the created date time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  @doc("String that represents the last action date time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActionDateTime?: utcDateTime;

  @doc("String that represents the start date time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  @doc("String that represents the stop date time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  stopDateTime?: utcDateTime;

  @doc("The information of the experiment run.")
  @visibility("read")
  runInformation?: ExperimentExecutionDetailsPropertiesRunInformation;
}

@doc("The information of the experiment run.")
model ExperimentExecutionDetailsPropertiesRunInformation {
  @doc("The steps of the experiment run.")
  @visibility("read")
  steps?: StepStatus[];
}

@doc("Model that represents the a list of branches and branch statuses.")
model StepStatus {
  @doc("The name of the step.")
  @visibility("read")
  stepName?: string;

  @doc("The id of the step.")
  @visibility("read")
  stepId?: string;

  @doc("The value of the status of the step.")
  @visibility("read")
  status?: string;

  @doc("The array of branches.")
  @visibility("read")
  branches?: BranchStatus[];
}

@doc("Model that represents the a list of actions and action statuses.")
model BranchStatus {
  @doc("The name of the branch status.")
  @visibility("read")
  branchName?: string;

  @doc("The id of the branch status.")
  @visibility("read")
  branchId?: string;

  @doc("The status of the branch.")
  @visibility("read")
  status?: string;

  @doc("The array of actions.")
  @visibility("read")
  actions?: ActionStatus[];
}

@doc("Model that represents the an action and its status.")
model ActionStatus {
  @doc("The name of the action status.")
  @visibility("read")
  actionName?: string;

  @doc("The id of the action status.")
  @visibility("read")
  actionId?: string;

  @doc("The status of the action.")
  @visibility("read")
  status?: string;

  @doc("String that represents the start time of the action.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("String that represents the end time of the action.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The array of targets.")
  @visibility("read")
  targets?: ExperimentExecutionActionTargetDetailsProperties[];
}

@doc("Model that represents the Experiment action target details properties model.")
model ExperimentExecutionActionTargetDetailsProperties {
  @doc("The status of the execution.")
  @visibility("read")
  status?: string;

  @doc("The target for the action.")
  @visibility("read")
  target?: string;

  @doc("String that represents the failed date time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  targetFailedTime?: utcDateTime;

  @doc("String that represents the completed date time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  targetCompletedTime?: utcDateTime;

  @doc("The error of the action.")
  @visibility("read")
  error?: ExperimentExecutionActionTargetDetailsError;
}

@doc("Model that represents the Experiment action target details error model.")
model ExperimentExecutionActionTargetDetailsError {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message")
  @visibility("read")
  message?: string;
}

@doc("Model that represents the base Target Type properties model.")
model TargetTypeProperties {
  @doc("Localized string of the display name.")
  @visibility("read")
  displayName?: string;

  @doc("Localized string of the description.")
  @visibility("read")
  description?: string;

  @doc("URL to retrieve JSON schema of the Target Type properties.")
  @visibility("read")
  @maxLength(2048)
  propertiesSchema?: string;

  @doc("List of resource types this Target Type can extend.")
  @visibility("read")
  resourceTypes?: string[];
}

@doc("Model that represents a delay action.")
model DelayAction extends Action {
  @doc("ISO8601 formatted string that represents a duration.")
  duration: duration;

  @doc("Enum that discriminates between action models.")
  type: "delay";
}

@doc("Model that represents a discrete action.")
model DiscreteAction extends Action {
  @doc("List of key value pairs.")
  parameters: KeyValuePair[];

  @doc("String that represents a selector.")
  @minLength(1)
  selectorId: string;

  @doc("Enum that discriminates between action models.")
  type: "discrete";
}

@doc("A map to describe the settings of an action.")
model KeyValuePair {
  @doc("The name of the setting for the action.")
  @minLength(1)
  key: string;

  @doc("The value of the setting for the action.")
  @minLength(1)
  value: string;
}

@doc("Model that represents a continuous action.")
model ContinuousAction extends Action {
  @doc("ISO8601 formatted string that represents a duration.")
  duration: duration;

  @doc("List of key value pairs.")
  parameters: KeyValuePair[];

  @doc("String that represents a selector.")
  @minLength(1)
  selectorId: string;

  @doc("Enum that discriminates between action models.")
  type: "continuous";
}

@doc("Model that represents a list selector.")
model ListSelector extends Selector {
  @doc("List of Target references.")
  targets: TargetReference[];

  @doc("Enum of the selector type.")
  type: "List";
}

@doc("Model that represents a reference to a Target in the selector.")
model TargetReference {
  @doc("Enum of the Target reference type.")
  type: TargetReferenceType;

  @doc("String of the resource ID of a Target resource.")
  @pattern("^\\/[Ss][Uu][Bb][Ss][Cc][Rr][Ii][Pp][Tt][Ii][Oo][Nn][Ss]\\/[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}\\/[Rr][Ee][Ss][Oo][Uu][Rr][Cc][Ee][Gg][Rr][Oo][Uu][Pp][Ss]\\/[a-zA-Z0-9_\\-\\.\\(\\)]*[a-zA-Z0-9_\\-\\(\\)]\\/[Pp][Rr][Oo][Vv][Ii][Dd][Ee][Rr][Ss]\\/[a-zA-Z0-9]+\\.[a-zA-Z0-9]+\\/[a-zA-Z0-9_\\-\\.]+\\/[a-zA-Z0-9_\\-\\.]+\\/[Pp][Rr][Oo][Vv][Ii][Dd][Ee][Rr][Ss]\\/[Mm][Ii][Cc][Rr][Oo][Ss][Oo][Ff][Tt]\\.[Cc][Hh][Aa][Oo][Ss]\\/[Tt][Aa][Rr][Gg][Ee][Tt][Ss]\\/[a-zA-Z0-9_\\-\\.]+$")
  id: string;
}

@doc("Model that represents a query selector.")
model QuerySelector extends Selector {
  @doc("Azure Resource Graph (ARG) Query Language query for target resources.")
  queryString: string;

  @doc("Subscription id list to scope resource query.")
  subscriptionIds: string[];

  @doc("Enum of the selector type.")
  type: "Query";
}

@doc("Model that represents a simple target filter.")
model SimpleFilter extends Filter {
  @doc("Model that represents the Simple filter parameters.")
  parameters?: SimpleFilterParameters;

  @doc("Enum that discriminates between filter types. Currently only `Simple` type is supported.")
  type: "Simple";
}

@doc("Model that represents the Simple filter parameters.")
model SimpleFilterParameters {
  @doc("List of Azure availability zones to filter targets by.")
  zones?: string[];
}
