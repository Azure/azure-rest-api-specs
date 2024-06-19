import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Impact;

@doc("A connector is a resource that can be used to proactively report impacts against workloads in Azure to Microsoft.")
@subscriptionResource
model Connector is ProxyResource<ConnectorProperties> {
  @doc("The name of the connector")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("connectorName")
  @segment("connectors")
  @path
  name: string;
}

@doc("Details of the Connector.")
model ConnectorProperties is ResourceProperties {
  @visibility("read")
  @doc("unique id of the connector.")
  connectorId: string;

  @visibility("read")
  @doc("tenant id of this connector")
  tenantId: string;

  @doc("connector type")
  connectorType: Platform;

  @visibility("read")
  @doc("last run time stamp of this connector in UTC time zone")
  lastRunTimeStamp: utcDateTime;
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
