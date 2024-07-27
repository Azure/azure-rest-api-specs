import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../shared/managedresourcegroupconfiguration.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@removed(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("EnclaveListItem Properties")
model EnclaveListItem {
  @doc("virtual enclave name.")
  name?: string;

  @doc("virtual enclaves resource id.")
  id?: VirtualEnclaveResourceId;

  @doc("creation datetime.")
  creationDatetime?: string;

  @doc("created by.")
  createdBy?: string;

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Identifier for governed services.")
union ServiceIdentifier {
  @doc("Service identifier for AKS")
  aks: "aks",

  @doc("Service identifier for App Service")
  appservice: "appservice",

  @doc("Service identifier for Azure Firewalls")
  azurefirewalls: "azurefirewalls",

  @doc("Service identifier for Container Registry")
  containerregistry: "containerregistry",

  @doc("Service identifier for CosmosDB")
  cosmosdb: "cosmosdb",

  @doc("Service identifier for Data Connectors")
  dataconnectors: "dataconnectors",

  @doc("Service identifier for insights")
  insights: "insights",

  @doc("Service identifier for Key Vault")
  keyvault: "keyvault",

  @doc("Service identifier for Logic")
  logic: "logic",

  @doc("Service identifier for Microsoft SQL")
  microsoftsql: "microsoftsql",

  @doc("Service identifier for Monitoring")
  monitoring: "monitoring",

  @doc("Service identifier for PostgreSql")
  postgresql: "postgresql",

  @doc("Service identifier for Private DNS Zones")
  privatednszones: "privatednszones",

  @doc("Service identifier for Service Bus")
  servicebus: "servicebus",

  @doc("Service identifier for Storage")
  storage: "storage",

  string,
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("GovernedServiceItem Properties")
model GovernedServiceItem {
  @doc("service id")
  id: ServiceIdentifier;

  @doc("service name")
  @visibility("read")
  name?: string;

  @doc("governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable).")
  option?: "Allow" | "Deny" | "ExceptionOnly" | "NotApplicable" | string;

  @doc("initiative enforcement (Enabled or Disabled).")
  enforcement?: "Enabled" | "Disabled" | string;

  @doc("policies set to auditOnly (True or False).")
  auditOnly?: boolean;

  @doc("initiatives associated with this service")
  @visibility("read")
  initiatives?: string[];
}

@doc("Community Resource Properties")
model CommunityProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Community Description.")
  description?: string;

  @doc("Address Space.")
  addressSpace?: string;

  @doc("Dns Servers.")
  dnsServers?: string[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("List of resource ids created by communities.")
  resourceCollection?: string[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("List of virtual enclaves that a community contains.")
  virtualEnclaveList?: EnclaveListItem[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Dictionary of virtual enclaves that a community contains.")
  virtualEnclaveCollection?: Record<EnclaveListItem>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("List of services governed by a community.")
  governedServiceList?: GovernedServiceItem[];
}
