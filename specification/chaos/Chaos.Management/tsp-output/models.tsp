import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ChaosManagementClient;

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

@doc("Model that represents a list of Capability resources and a link for pagination.")
model CapabilityListResult is Azure.Core.Page<Capability>;

@doc("Model that represents a Capability resource.")
model Capability {
  ...Resource;

  @doc("The standard system metadata of a resource type.")
  @visibility("read")
  systemData?: SystemData;

  @doc("The properties of a capability resource.")
  @visibility("read")
  properties?: CapabilityProperties;
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
  parametersSchema?: string;

  @doc("String of the URN for this Capability Type.")
  @visibility("read")
  urn?: string;
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

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("""
Model that represents a list of Capability Type resources and a link for
pagination.
""")
model CapabilityTypeListResult is Azure.Core.Page<CapabilityType>;

@doc("Model that represents a Capability Type resource.")
model CapabilityType {
  ...Resource;

  @doc("The system metadata properties of the capability type resource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Location of the Capability Type resource.")
  location?: string;

  @doc("The properties of the capability type resource.")
  @visibility("read")
  properties?: CapabilityTypeProperties;
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
  parametersSchema?: string;

  @doc("String of the URN for this Capability Type.")
  @visibility("read")
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

@doc("Model that represents a list of Experiment resources and a link for pagination.")
model ExperimentListResult is Azure.Core.Page<Experiment>;

@doc("Model that represents a Experiment resource.")
model Experiment {
  ...TrackedResource;

  @doc("The system metadata of the experiment resource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("The identity of the experiment resource.")
  identity?: ResourceIdentity;

  @doc("The properties of the experiment resource.")
  properties: ExperimentProperties;
}

@doc("The identity of a resource.")
model ResourceIdentity {
  @doc("String of the resource identity type.")
  type: ResourceIdentityType;

  @doc("""
The list of user identities associated with the Experiment. The user identity
dictionary key references will be ARM resource ids in the form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
""")
  userAssignedIdentities?: Record<UserAssignedIdentity>;

  @doc("GUID that represents the principal ID of this resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("GUID that represents the tenant ID of this resource identity.")
  @visibility("read")
  tenantId?: string;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Model that represents the Experiment properties model.")
model ExperimentProperties {
  @doc("List of steps.")
  steps: Step[];

  @doc("List of selectors.")
  selectors: Selector[];

  @doc("""
A boolean value that indicates if experiment should be started on creation or
not.
""")
  startOnCreation?: boolean;
}

@doc("Model that represents a step in the Experiment resource.")
model Step {
  @doc("String of the step name.")
  name: string;

  @doc("List of branches.")
  branches: Branch[];
}

@doc("Model that represents a branch in the step.")
model Branch {
  @doc("String of the branch name.")
  name: string;

  @doc("List of actions.")
  actions: Action[];
}

@doc("Model that represents the base action model.")
@discriminator("type")
model Action {
  @doc("String that represents a Capability URN.")
  name: string;
}

@doc("Model that represents a selector in the Experiment resource.")
@discriminator("type")
model Selector {
  ...Record<unknown>;

  @doc("String of the selector ID.")
  id: string;

  @doc("""
Model that represents available filter types that can be applied to a targets
list.
""")
  filter?: Filter;
}

@doc("""
Model that represents available filter types that can be applied to a targets
list.
""")
@discriminator("type")
model Filter {}

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
  statusUrl?: string;
}

@doc("Model that represents the result of a start Experiment operation.")
model ExperimentStartOperationResult {
  @doc("String of the Experiment name.")
  @visibility("read")
  name?: string;

  @doc("URL to retrieve the Experiment status.")
  @visibility("read")
  statusUrl?: string;
}

@doc("Model that represents a list of Experiment statuses and a link for pagination.")
model ExperimentStatusListResult is Azure.Core.Page<ExperimentStatus>;

@doc("Model that represents the status of a Experiment.")
model ExperimentStatus {
  @doc("String of the resource type.")
  @visibility("read")
  type?: string;

  @doc("String of the fully qualified resource ID.")
  @visibility("read")
  id?: string;

  @doc("String of the resource name.")
  @visibility("read")
  name?: string;

  @doc("The properties of experiment execution status.")
  properties?: ExperimentStatusProperties;
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

@doc("""
Model that represents a list of Experiment execution details and a link for
pagination.
""")
model ExperimentExecutionDetailsListResult
  is Azure.Core.Page<ExperimentExecutionDetails>;

@doc("Model that represents the execution details of a Experiment.")
model ExperimentExecutionDetails {
  @doc("String of the resource type.")
  @visibility("read")
  type?: string;

  @doc("String of the fully qualified resource ID.")
  @visibility("read")
  id?: string;

  @doc("String of the resource name.")
  @visibility("read")
  name?: string;

  @doc("The properties of the experiment execution details.")
  @visibility("read")
  properties?: ExperimentExecutionDetailsProperties;
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

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}

@doc("Model that represents a list of Target Type resources and a link for pagination.")
model TargetTypeListResult is Azure.Core.Page<TargetType>;

@doc("Model that represents a Target Type resource.")
model TargetType {
  ...Resource;

  @doc("The system metadata properties of the target type resource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Location of the Target Type resource.")
  location?: string;

  @doc("The properties of the target type resource.")
  properties: TargetTypeProperties;
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
  propertiesSchema?: string;

  @doc("List of resource types this Target Type can extend.")
  @visibility("read")
  resourceTypes?: string[];
}

@doc("Model that represents a list of Target resources and a link for pagination.")
model TargetListResult is Azure.Core.Page<Target>;

@doc("Model that represents a Target resource.")
model Target {
  ...Resource;

  @doc("The system metadata of the target resource.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Location of the target resource.")
  location?: string;

  @doc("The properties of the target resource.")
  properties: Record<unknown>;
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
  selectorId: string;

  @doc("Enum that discriminates between action models.")
  type: "discrete";
}

@doc("A map to describe the settings of an action.")
model KeyValuePair {
  @doc("The name of the setting for the action.")
  key: string;

  @doc("The value of the setting for the action.")
  value: string;
}

@doc("Model that represents a continuous action.")
model ContinuousAction extends Action {
  @doc("ISO8601 formatted string that represents a duration.")
  duration: duration;

  @doc("List of key value pairs.")
  parameters: KeyValuePair[];

  @doc("String that represents a selector.")
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

  @doc("""
Enum that discriminates between filter types. Currently only `Simple` type is
supported.
""")
  type: "Simple";
}

@doc("Model that represents the Simple filter parameters.")
model SimpleFilterParameters {
  @doc("List of Azure availability zones to filter targets by.")
  zones?: string[];
}
