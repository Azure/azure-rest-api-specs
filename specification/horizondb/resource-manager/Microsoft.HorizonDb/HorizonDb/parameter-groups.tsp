import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@doc("Represents the HorizonDB parameter group.")
model ParameterGroup
  is Azure.ResourceManager.TrackedResource<ParameterGroupProperties> {
  @doc("The name of the HorizonDB parameter group.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("parameterGroupName")
  @path
  @segment("parameterGroups")
  name: string;
}

@doc("Properties of a HorizonDB parameter group.")
model ParameterGroupProperties {
  @doc("Parameters in the parameter group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  parameters?: ParameterProperties[];

  @doc("Description of the parameter group. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: WritableDescription;

  @doc("The PostgreSQL major version for the parameter group. This property is required during creation and is immutable thereafter. The service selects the unique location-scoped default parameter group for this version in the resource location. The DefaultParameterGroups APIs return at most one default parameter group for each PostgreSQL version in a location, so this selection is unambiguous.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  postgreSqlVersion: PostgreSqlVersion;

  @doc("The provisioning state of the parameter group.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The source of the effective value assigned to a HorizonDB parameter.")
union ParameterValueSource {
  string,

  /** The effective value is the system-defined default. */
  SystemDefault: "SystemDefault",

  /** The effective value was explicitly supplied by the user, even when it equals the system-defined default value. */
  UserOverride: "UserOverride",
}

@doc("Properties of a HorizonDB parameter.")
model ParameterProperties {
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @doc("The name of the parameter.")
  name?: string;

  @visibility(Lifecycle.Read)
  @doc("The description of the parameter.")
  description?: string;

  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @doc("The value of the configuration.")
  value?: string;

  @visibility(Lifecycle.Read)
  @doc("The system-defined default value of the parameter, independent of the effective value.")
  defaultValue?: string;

  @visibility(Lifecycle.Read)
  @doc("The source of the effective parameter value. UserOverride means that the value was explicitly supplied by the user, even when it equals defaultValue.")
  valueSource?: ParameterValueSource;

  @visibility(Lifecycle.Read)
  @doc("The data type of the parameter.")
  dataType?: string;

  @visibility(Lifecycle.Read)
  @doc("The allowed values for the parameter.")
  allowedValues?: string;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter can be changed dynamically.")
  isDynamic?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter is read-only. Read-only parameters cannot be overridden.")
  isReadOnly?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Link to parameter documentation.")
  documentationLink?: url;

  @visibility(Lifecycle.Read)
  @doc("The unit of measurement for the parameter.")
  unit?: string;
}

@doc("Properties of a HorizonDB parameter group for update operations.")
model ParameterGroupPropertiesForPatchUpdate {
  @doc("Parameters in the parameter group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Update)
  parameters?: ParameterProperties[];

  @doc("Description of the parameter group. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Update)
  description?: WritableDescription;
}

@doc("HorizonDB parameter group for update operations.")
model ParameterGroupForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The properties that can be updated for a HorizonDB parameter group.")
  properties?: ParameterGroupPropertiesForPatchUpdate;
}

@doc("Connection information for HorizonDB parameter group.")
model ParameterGroupConnectionProperties {
  @doc("The Azure resource ID of the connected HorizonDB pool.")
  @visibility(Lifecycle.Read)
  poolResourceId: PoolResourceId;
}

@doc("A page of HorizonDB parameter group connections.")
model PagedParameterGroupConnectionProperties {
  @doc("The parameter group connection items on this page.")
  @pageItems
  @identifiers(#["poolResourceId"])
  value: ParameterGroupConnectionProperties[];

  @doc("The link to the next page of items.")
  @nextLink
  nextLink?: url;
}

@doc("A default parameter group available in a specific region. It contains engine-defined parameters and excludes service and other non-engine entries. For each PostgreSQL version, the DefaultParameterGroups APIs return at most one default parameter group in a location.")
@parentResource(SubscriptionLocationResource)
model DefaultParameterGroup is ProxyResource<DefaultParameterGroupProperties> {
  ...ResourceNameParameter<
    Resource = DefaultParameterGroup,
    KeyName = "name",
    SegmentName = "parameterGroups",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
}

@doc("Properties of a default parameter group.")
model DefaultParameterGroupProperties {
  @doc("The provisioning state of the default parameter group.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Engine-defined parameters in the default parameter group. Service and other non-engine entries are excluded.")
  @identifiers(#["name"])
  parameters: ParameterProperties[];

  @doc("Description of the default parameter group.")
  description?: string;

  @doc("PostgreSQL version for which this default parameter group is valid.")
  postgreSqlVersion: PostgreSqlVersion;
}

@doc("Connection information for HorizonDB parameter group.")
model HorizonDbClusterParameterGroupConnectionProperties {
  @doc("The resource ID of the connected parameter group.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  id?: armResourceIdentifier;

  @doc("Indication of if parameter group is applied on HorizonDB resource.")
  @visibility(Lifecycle.Read)
  syncStatus?: ParameterGroupSyncStatus;
}

@doc("Controls when dynamic parameter changes become effective. Static parameter changes always become effective only after a customer-initiated pool Restart. Stop followed by Start and scheduled maintenance do not apply pending parameter changes.")
union ParameterApplyMethod {
  string,

  /** Apply dynamic parameter changes immediately. Static parameter changes remain pending until a customer-initiated pool Restart. */
  Immediate: "Immediate",

  /** Keep dynamic and static parameter changes pending until a customer-initiated pool Restart. Stop followed by Start and scheduled maintenance do not apply them. */
  PendingReboot: "PendingReboot",
}

@doc("Indicates synchronization status between a HorizonDB resource and its parameter group.")
union ParameterGroupSyncStatus {
  string,

  /** Parameter updates are currently being applied. */
  Applying: "Applying",

  /** Parameter values are synchronized and up to date. */
  InSync: "InSync",

  /** Applying parameter updates failed. */
  FailedToApply: "FailedToApply",

  /** Parameter updates are pending and require a customer-initiated pool Restart to take effect. Stop followed by Start and scheduled maintenance preserve this status. */
  PendingReboot: "PendingReboot",
}

@armResourceOperations
interface ParameterGroups {
  @doc("Gets information about a HorizonDB parameter group.")
  get is ArmResourceRead<ParameterGroup>;

  @doc("Creates a new HorizonDB parameter group or replaces an existing parameter group.")
  @sharedRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ParameterGroup>;

  @sharedRoute
  @doc("Updates an existing HorizonDB parameter group. Each connected pool's applyMethod setting controls whether dynamic parameter changes become effective immediately or remain pending until a customer-initiated pool Restart. Static parameter changes always remain pending until a customer-initiated pool Restart. Stop followed by Start and scheduled maintenance do not apply pending changes. The operation fails with a conflict while a previous update to this parameter group is still being processed.")
  update is ArmCustomPatchAsync<ParameterGroup, ParameterGroupForPatchUpdate>;

  @sharedRoute
  @doc("Deletes a HorizonDB parameter group. Deletion fails with a conflict when the parameter group is associated with one or more pools.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ParameterGroup,
    Response =
      | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  @doc("Lists all HorizonDB parameter groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ParameterGroup>;

  @doc("Lists all HorizonDB parameter groups in a subscription.")
  listBySubscription is ArmListBySubscription<ParameterGroup>;

  @doc("Gets all connections to a parameter group.")
  @get
  @list
  @action("connections")
  listConnections is ArmResourceActionSync<
    ParameterGroup,
    void,
    ArmResponse<PagedParameterGroupConnectionProperties>
  >;
}

@armResourceOperations
interface DefaultParameterGroups {
  @doc("Lists default parameter groups available for a subscription in a specific region. The response contains at most one default parameter group for each PostgreSQL version.")
  listBySubscriptionAndRegion is ArmResourceListByParent<DefaultParameterGroup>;

  @doc("Gets a default parameter group available for a subscription in a specific region. Each PostgreSQL version has at most one default parameter group in a location.")
  get is ArmResourceRead<DefaultParameterGroup>;
}
