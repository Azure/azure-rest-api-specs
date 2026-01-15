// cspell:enableCompoundWords
// cspell:words managedonbehalfofconfiguration

import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Identifier for governed services.")
union ServiceIdentifier {
  string,

  @doc("Service identifier for AKS")
  AKS: "AKS",

  @doc("Service identifier for App Service")
  AppService: "AppService",

  @doc("Service identifier for Azure Firewalls")
  AzureFirewalls: "AzureFirewalls",

  @doc("Service identifier for Container Registry")
  ContainerRegistry: "ContainerRegistry",

  @doc("Service identifier for CosmosDB")
  CosmosDB: "CosmosDB",

  @doc("Service identifier for Data Connectors")
  DataConnectors: "DataConnectors",

  @doc("Service identifier for Insights")
  Insights: "Insights",

  @doc("Service identifier for Key Vault")
  KeyVault: "KeyVault",

  @doc("Service identifier for Logic")
  Logic: "Logic",

  @doc("Service identifier for Microsoft SQL")
  MicrosoftSql: "MicrosoftSQL",

  @doc("Service identifier for Monitoring")
  Monitoring: "Monitoring",

  @doc("Service identifier for PostgreSQL")
  PostgreSql: "PostgreSQL",

  @doc("Service identifier for Private DNS Zones")
  PrivateDNSZones: "PrivateDNSZones",

  @doc("Service identifier for Service Bus")
  ServiceBus: "ServiceBus",

  @doc("Service identifier for Storage")
  Storage: "Storage",
}

@doc("Governed Service Item Option")
union GovernedServiceItemOption {
  string,

  @doc("GovernedServiceItemOption Allow")
  Allow: "Allow",

  @doc("GovernedServiceItemOption Deny")
  Deny: "Deny",

  @doc("GovernedServiceItemOption ExceptionOnly")
  ExceptionOnly: "ExceptionOnly",

  @doc("GovernedServiceItemOption NotApplicable")
  NotApplicable: "NotApplicable",
}

@doc("Governed Service Item Enforcement")
union GovernedServiceItemEnforcement {
  string,

  @doc("GovernedServiceItemEnforcement Enabled")
  Enabled: "Enabled",

  @doc("GovernedServiceItemEnforcement Disabled")
  Disabled: "Disabled",
}

@doc("Policy Action")
union PolicyAction {
  string,

  @doc("PolicyAction AuditOnly")
  AuditOnly: "AuditOnly",

  @doc("PolicyAction Enforce")
  Enforce: "Enforce",

  @doc("PolicyAction None")
  None: "None",
}

@doc("GovernedServiceItem Properties")
model GovernedServiceItem {
  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "id")
  @doc("Service ID")
  serviceId: ServiceIdentifier;

  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "name")
  @doc("Service name.")
  @visibility(Lifecycle.Read)
  serviceName?: string;

  @doc("Governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable).")
  option?: GovernedServiceItemOption;

  @doc("Initiative enforcement (Enabled or Disabled).")
  enforcement?: GovernedServiceItemEnforcement;

  @removed(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Policies set to auditOnly (True or False).")
  auditOnly?: boolean;

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Enforcement mode for policy. AuditOnly, Enforce, or None.")
  policyAction?: PolicyAction;

  @doc("Initiatives associated with this service.")
  @visibility(Lifecycle.Read)
  initiatives?: string[];
}
