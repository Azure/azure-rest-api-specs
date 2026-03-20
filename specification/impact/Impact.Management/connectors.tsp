import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Impact;

@doc("A connector is a resource that can be used to proactively report impacts against workloads in Azure to Microsoft.")
@subscriptionResource
model Connector is Azure.ResourceManager.ProxyResource<ConnectorProperties> {
  @doc("The name of the connector")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("connectorName")
  @segment("connectors")
  @path
  name: string;

  ...ConnectorManagedUserAssignedIdentityProperty;
}

@added(Versions.v2025_01_01_preview)
@doc("The managed service identities envelope.")
model ConnectorManagedUserAssignedIdentityProperty {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "There is no built-in typespec support for MSI with only UserAssigned type; we must create custom models for this."
  @added(Versions.v2025_01_01_preview)
  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityOnlyUserAssigned;
}

@added(Versions.v2025_01_01_preview)
@doc("Managed service identity (system assigned and/or user assigned identities)")
model ManagedServiceIdentityOnlyUserAssigned {
  @doc("The type of managed identity assigned to this resource.")
  type: ManagedServiceIdentityTypeOnlyUserAssigned;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "There is no built-in typespec support for MSI wih only UserAssigned type; we must create custom models for this."
  @doc("The identities assigned to this resource by the user.")
  userAssignedIdentities?: Record<Foundations.UserAssignedIdentity | null>;
}

@added(Versions.v2025_01_01_preview)
@doc("Type of managed service identity, where only UserAssigned type is allowed.")
union ManagedServiceIdentityTypeOnlyUserAssigned {
  @doc("User assigned managed identity.")
  UserAssigned: "UserAssigned",

  @doc("No identity.")
  None: "None",

  string,
}

@doc("Details of the Connector.")
model ConnectorProperties is ResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("unique id of the connector.")
  connectorId: string;

  @visibility(Lifecycle.Read)
  @doc("tenant id of this connector")
  tenantId: string;

  @doc("connector type")
  connectorType: Platform;

  @visibility(Lifecycle.Read)
  @doc("last run time stamp of this connector in UTC time zone")
  lastRunTimeStamp: utcDateTime;

  @added(Versions.v2025_01_01_preview)
  @visibility(Lifecycle.Read)
  @doc("returns the processing state of a connector")
  processingState: string;

  @added(Versions.v2025_01_01_preview)
  @visibility(Lifecycle.Read)
  @doc("detailed description of the state and if any associated action that can be taken")
  processingStateMessage: string;
}

@doc("Enum for connector types")
union Platform {
  string,

  @doc("Type of Azure Monitor")
  AzureMonitor: "AzureMonitor",
}

@armResourceOperations(Connector)
interface Connectors {
  get is ArmResourceRead<Connector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Connector>;
  update is ArmResourcePatchSync<Connector, ConnectorProperties>;
  delete is ArmResourceDeleteSync<Connector>;
  listBySubscription is ArmListBySubscription<Connector>;
}
