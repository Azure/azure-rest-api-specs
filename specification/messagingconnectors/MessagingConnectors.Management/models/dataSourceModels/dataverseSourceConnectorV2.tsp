import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.DataverseV2;

@doc("The position of events in an Event Hub partition")
union DataverseV2EventPosition {
  @doc("Corresponds to the first record of the partition.")
  Earliest: "Earliest",

  @doc("Corresponds to the end of the partition.")
  Latest: "Latest",

  string,
}

@doc("The operation to be performed on the Dataverse table")
union DataverseV2OperationName {
  @doc("Upsert operation")
  Upsert: "Upsert",

  @doc("Delete operation")
  Delete: "Delete",

  string,
}

@doc("Properties of a Dataverse table")
model DataverseV2TableProperty {
  @doc("Name of the Dataverse table")
  tableName: string;

  @doc("List of columns in the Dataverse table")
  columns: string[];

  @doc("Name of the operation to be performed on the Dataverse table")
  operationNames: DataverseV2OperationName[];
}

@doc("Configuration for DataverseSourceConnectorV2 created for dataverse pull based design")
model DataverseSourceConnectorV2Properties extends DataSourceProperties {
  @doc("Type of DataverseSourceConnector V2")
  connectorType: Models.Connector.ConnectorType.DataverseSourceV2;

  @doc("Namespace of the EventHub.")
  eventHubNamespaceHostname: string;

  @doc("Name of the EventHub.")
  eventHub: string;

  @doc("ConsumerGroup of the EventHub.")
  consumerGroup: string;

  @doc("The position of events in an Event Hub partition.")
  startEventPosition: DataverseV2EventPosition;

  @doc("Authentication for EventHub, OAuth or ConnectionString.")
  authentication: Models.Auth.Authentication;

  @doc("OffsetStartTime in utcDateTime zone.")
  offsetStartTime?: utcDateTime;

  @doc("URL of the Dataverse environment")
  dataverseEnvironmentUrl: string;

  @Azure.ResourceManager.identifiers(#[])
  @doc("List of Dataverse table properties")
  dataverseTableProperties: DataverseV2TableProperty[];
}
