import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@renamedFrom(Versions.v2026_10_01, "HorizonDbParameterGroup")
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

@renamedFrom(Versions.v2026_10_01, "HorizonDbParameterGroupProperties")
@doc("Properties of a HorizonDB parameter group.")
model ParameterGroupProperties {
  @doc("Parameters in the parameter group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @typeChangedFrom(Versions.v2026_10_01, LegacyParameterProperties[])
  parameters?: ParameterProperties[];

  @removed(Versions.v2026_10_01)
  @doc("Description of the parameter group.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  @renamedFrom(Versions.v2026_10_01, "description")
  legacyDescription?: string;

  @added(Versions.v2026_10_01)
  @doc("Description of the parameter group. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: WritableDescription;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "pgVersion")
  @doc("PostgreSQL version for the parameter group.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  legacyPgVersion?: int32;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "version")
  @doc("Current version of the parameter group.")
  @visibility(Lifecycle.Read)
  currentVersion?: int32;

  @added(Versions.v2026_10_01)
  @doc("The PostgreSQL major version for the parameter group. This property is required during creation and is immutable thereafter. The service selects the unique location-scoped default parameter group for this version in the resource location. The DefaultParameterGroups APIs return at most one default parameter group for each PostgreSQL version in a location, so this selection is unambiguous.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  postgreSqlVersion: PostgreSqlVersion;

  @removed(Versions.v2026_10_01)
  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  applyImmediately?: boolean;

  @added(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "applyImmediately")
  @doc("Determines when dynamic parameter changes become effective. Static parameter changes always require a restart of each connected pool, regardless of this value.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  applyMethod?: ParameterApplyMethod;

  @doc("The provisioning state of the parameter group.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@removed(Versions.v2026_10_01)
@renamedFrom(Versions.v2026_10_01, "ParameterProperties")
@doc("Properties of a HorizonDB parameters.")
model LegacyParameterProperties {
  @doc("The name of the parameter.")
  name?: string;

  @visibility(Lifecycle.Read)
  @doc("The description of the parameter.")
  description?: string;

  @doc("The value of the configuration.")
  value?: string;

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
  @doc("Whether the parameter is a read-only parameter.")
  isReadOnly?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Link to parameter documentation.")
  documentationLink?: url;

  @visibility(Lifecycle.Read)
  @doc("The unit of measurement for the parameter.")
  unit?: string;
}

@added(Versions.v2026_10_01)
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
  @doc("The data type of the parameter.")
  dataType?: string;

  @visibility(Lifecycle.Read)
  @doc("The allowed values for the parameter.")
  allowedValues?: string;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter can be changed dynamically.")
  isDynamic?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Whether the parameter is a read-only parameter.")
  isReadOnly?: boolean;

  @visibility(Lifecycle.Read)
  @doc("Link to parameter documentation.")
  documentationLink?: url;

  @visibility(Lifecycle.Read)
  @doc("The unit of measurement for the parameter.")
  unit?: string;
}

@renamedFrom(
  Versions.v2026_10_01,
  "HorizonDbParameterGroupPropertiesForPatchUpdate"
)
@doc("Properties of a HorizonDB parameter group for update operations.")
model ParameterGroupPropertiesForPatchUpdate {
  @doc("Parameters in the parameter group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Update)
  @typeChangedFrom(Versions.v2026_10_01, LegacyParameterProperties[])
  parameters?: ParameterProperties[];

  @removed(Versions.v2026_10_01)
  @doc("Description of the parameter group.")
  @visibility(Lifecycle.Update)
  @renamedFrom(Versions.v2026_10_01, "description")
  legacyDescription?: string;

  @added(Versions.v2026_10_01)
  @doc("Description of the parameter group. The maximum length is 1024 characters.")
  @visibility(Lifecycle.Update)
  description?: WritableDescription;

  @removed(Versions.v2026_10_01)
  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Update)
  applyImmediately?: boolean;

  @added(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "applyImmediately")
  @doc("Determines when dynamic parameter changes in this request become effective. This property is required when parameters is supplied and optional otherwise. Static parameter changes always require a restart of each connected pool, regardless of this value.")
  @visibility(Lifecycle.Update)
  applyMethod?: ParameterApplyMethod;
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbParameterGroupForPatchUpdate")
@doc("HorizonDB parameter group for update operations.")
model ParameterGroupForPatchUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The properties that can be updated for a HorizonDB parameter group.")
  properties?: ParameterGroupPropertiesForPatchUpdate;
}

@renamedFrom(
  Versions.v2026_10_01,
  "HorizonDbParameterGroupConnectionProperties"
)
@doc("Connection information for HorizonDB parameter group.")
model ParameterGroupConnectionProperties {
  @removed(Versions.v2026_10_01)
  @doc("The name of the connected resource.")
  @visibility(Lifecycle.Read)
  name?: string;

  @removed(Versions.v2026_10_01)
  @doc("The resource ID of the connected resource.")
  @visibility(Lifecycle.Read)
  id?: armResourceIdentifier;

  @removed(Versions.v2026_10_01)
  @doc("The type of the resource.")
  @visibility(Lifecycle.Read)
  type?: string;

  @added(Versions.v2026_10_01)
  @doc("The Azure resource ID of the connected HorizonDB pool.")
  @visibility(Lifecycle.Read)
  poolResourceId: PoolResourceId;
}

@added(Versions.v2026_10_01)
@doc("A default parameter group available in a specific region. For each PostgreSQL version, the DefaultParameterGroups APIs return at most one default parameter group in a location.")
model DefaultParameterGroup {
  @doc("The unique name of the default parameter group.")
  name: string;

  @doc("Parameters in the default parameter group.")
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
  @typeChangedFrom(Versions.v2026_10_01, string)
  syncStatus?: ParameterGroupSyncStatus;

  @removed(Versions.v2026_10_01)
  @doc("Indicates whether the parameters should be applied immediately.")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  applyImmediately?: boolean;
}

@added(Versions.v2026_10_01)
@doc("Controls when dynamic parameter changes become effective. Static parameter changes always become effective only after a pool restart, whether initiated by the customer or performed during scheduled maintenance.")
union ParameterApplyMethod {
  string,

  /** Apply dynamic parameter changes immediately. Static parameter changes remain pending until the pool restarts. */
  Immediate: "Immediate",

  /** Apply dynamic and static parameter changes when the pool next restarts, whether initiated by the customer or performed during scheduled maintenance. */
  PendingReboot: "PendingReboot",
}

@added(Versions.v2026_10_01)
@doc("Indicates synchronization status between a HorizonDB resource and its parameter group.")
union ParameterGroupSyncStatus {
  string,

  /** Parameter updates are currently being applied. */
  Applying: "Applying",

  /** Parameter values are synchronized and up to date. */
  InSync: "InSync",

  /** Applying parameter updates failed. */
  FailedToApply: "FailedToApply",

  /** Parameter updates are pending and require a reboot to take effect. */
  PendingReboot: "PendingReboot",
}

@renamedFrom(Versions.v2026_10_01, "HorizonDbParameterGroups")
@armResourceOperations
interface ParameterGroups {
  @doc("Gets information about a HorizonDB parameter group.")
  get is ArmResourceRead<ParameterGroup>;

  @doc("Creates a new HorizonDB parameter group or updates an existing parameter group.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ParameterGroup>;

  @removed(Versions.v2026_10_01)
  @renamedFrom(Versions.v2026_10_01, "update")
  @sharedRoute
  @doc("Updates an existing HorizonDB parameter group. A request-wide applyMethod is required and controls when dynamic parameter changes become effective on connected pools. Static parameter changes always require a customer-triggered restart or a restart during scheduled maintenance. The operation fails with a conflict while a previous update to this parameter group is still being applied to connected pools.")
  updateV1 is ArmCustomPatchAsync<ParameterGroup, ParameterGroupForPatchUpdate>;

  @added(Versions.v2026_10_01)
  @sharedRoute
  @doc("Updates an existing HorizonDB parameter group. When parameters is supplied, applyMethod is required and controls when dynamic parameter changes become effective on connected pools. Tags-only and description-only updates do not require applyMethod. Static parameter changes always require a customer-triggered restart or a restart during scheduled maintenance. The operation fails with a conflict while a previous update to this parameter group is still being applied to connected pools.")
  update is ArmCustomPatchAsync<ParameterGroup, ParameterGroupForPatchUpdate>;

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
    ArmResponse<Azure.ResourceManager.ResourceListResult<ParameterGroupConnectionProperties>>
  >;

  @removed(Versions.v2026_10_01)
  @doc("Lists parameter groups filtered by version number.")
  @get
  @list
  @action("versions")
  listVersions is ArmResourceActionSync<
    ParameterGroup,
    void,
    ArmResponse<Azure.ResourceManager.ResourceListResult<ParameterGroup>>,
    Parameters = {
      @doc("The version number to filter by.")
      @query
      version?: int32;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom non-resource subscription-level operation with explicit route and parameters."
@added(Versions.v2026_10_01)
@route("/subscriptions/{subscriptionId}/providers/Microsoft.HorizonDb/locations/{location}/parameterGroups")
interface DefaultParameterGroups {
  @doc("Lists default parameter groups available for a subscription in a specific region. The response contains at most one default parameter group for each PostgreSQL version.")
  @get
  @list
  listDefaultParameterGroupsBySubscriptionAndRegion(
    ...ApiVersionParameter,

    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string,

    @doc("The Azure region for which to list default parameter groups.")
    @path
    location: Azure.Core.azureLocation,
  ): ArmResponse<Azure.ResourceManager.ResourceListResult<DefaultParameterGroup>>;

  @doc("Gets a default parameter group available for a subscription in a specific region. Each PostgreSQL version has at most one default parameter group in a location.")
  @route("/{name}")
  @get
  getDefaultParameterGroup(
    ...ApiVersionParameter,

    @doc("The Azure subscription ID.")
    @path
    subscriptionId: string,

    @doc("The Azure region containing the default parameter group.")
    @path
    location: Azure.Core.azureLocation,

    @doc("The name of the default parameter group.")
    @path
    name: string,
  ): ArmResponse<DefaultParameterGroup>;
}
