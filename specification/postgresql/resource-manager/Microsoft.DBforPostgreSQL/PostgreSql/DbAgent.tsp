import "./Server.tsp";
import "@typespec/openapi";
import "./shared.tsp";
import "@typespec/versioning";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;

@doc("The database agent configuration for a PostgreSQL flexible server.")
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
@singleton("Default")
@parentResource(Server)
model DbAgent is Azure.ResourceManager.ProxyResource<DbAgentProperties> {
  ...ResourceNameParameter<
    Resource = DbAgent,
    KeyName = "dbAgentName",
    SegmentName = "dbAgents",
    NamePattern = "^Default$"
  >;
}

@doc("Properties of the database agent configuration.")
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
model DbAgentProperties {
  @doc("The state of the database agent.")
  @visibility(Lifecycle.Read)
  state: DbAgentState;

  @doc("The provisioning state of the database agent resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: DbAgentProvisioningState;

  @doc("The time when the database agent configuration was last modified.")
  @visibility(Lifecycle.Read)
  lastModifiedTime?: utcDateTime;
}

@doc("A request to enable or disable the database agent.")
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
model DbAgentForUpdate {
  @doc("The requested database agent properties.")
  properties: DbAgentForUpdateProperties;
}

@doc("Writable properties of the database agent configuration.")
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
model DbAgentForUpdateProperties {
  @doc("The requested state of the database agent.")
  state: DbAgentForUpdateState;
}

@doc("The state of the database agent.")
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
union DbAgentState {
  string,

  @doc("The database agent is being enabled.")
  Enabling: "Enabling",

  @doc("The database agent is enabled.")
  Enabled: "Enabled",

  @doc("The database agent is being disabled.")
  Disabling: "Disabling",

  @doc("The database agent is disabled.")
  Disabled: "Disabled",

  @doc("The database agent lifecycle operation failed.")
  Failed: "Failed",
}

@doc("The provisioning state of the database agent resource.")
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
union DbAgentProvisioningState {
  ResourceProvisioningState,

  @doc("The database agent lifecycle operation is in progress.")
  InProgress: "InProgress",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "PUT requests accept only Enabled or Disabled; additional values must be rejected."
@doc("The database agent states accepted in a write request.")
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
union DbAgentForUpdateState {
  @doc("Enable the database agent.")
  Enabled: "Enabled",

  @doc("Disable the database agent.")
  Disabled: "Disabled",
}

@doc("The response returned when a database agent write is accepted.")
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
model DbAgentAcceptedResponse {
  ...AcceptedResponse;
  ...ArmCombinedLroHeaders<FinalResult = DbAgent>;
  ...Azure.Core.Foundations.RetryAfterHeader;

  @doc("The database agent resource while the lifecycle operation is in progress.")
  @bodyRoot
  resource: DbAgent;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The database agent is enabled or disabled through PUT and the service does not support DELETE."
@armResourceOperations
@added(Versions.v2026_07_01)
@removed(Versions.v2026_10_01)
interface DbAgents {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The service contract requires the DBAgent_List operation ID."
  @doc("Lists the database agent configuration for a flexible server.")
  @operationId("DBAgent_List")
  list is ArmResourceListByParent<DbAgent>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The service contract requires the DBAgent_Get operation ID."
  @doc("Gets the database agent configuration for a flexible server.")
  @operationId("DBAgent_Get")
  get is ArmResourceRead<DbAgent>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The implemented service contract returns HTTP 202 for every database agent write."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The implemented service contract returns the in-progress database agent resource in the HTTP 202 response body."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The service contract requires the DBAgent_CreateOrUpdate operation ID."
  @doc("Enables or disables the database agent for a flexible server.")
  @operationId("DBAgent_CreateOrUpdate")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @put
  createOrUpdate is Legacy.CreateOrReplaceAsync<
    DbAgent,
    Request = DbAgentForUpdate,
    Response = DbAgentAcceptedResponse
  >;
}
