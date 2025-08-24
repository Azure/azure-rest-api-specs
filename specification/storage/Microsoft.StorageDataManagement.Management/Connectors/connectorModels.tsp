import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Storage;

// Connector Properties
@doc("Details of the Storage Connector.")
model ConnectorProperties {
  @visibility(Lifecycle.Read)
  @doc("System-generated identifier for the Storage Connector. Not a valid input parameter when creating.")
  uniqueId?: string;

  @doc("State - Active or Inactive. Whether or not the Storage Connector should start as active (default: Active) (While set to false on the Storage Connector, all data plane requests using this Storage Connector fail, and this Storage Connector is not billed if it would be otherwise.)")
  state?: State = State.Active;

  @visibility(Lifecycle.Read)
  @doc("System-generated creation time for the Storage Connector. Not a valid input parameter when creating.")
  creationTime?: string;

  @doc("Arbitrary description of this Storage Connector. Max 250 characters.")
  @maxLength(250)
  description?: string;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("Test connection to backing data source before creating the storage connector.")
  testConnection?: boolean = false;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The source of the backing data source.")
  dataSourceType: DataSourceType;

  @doc("Information about how to communicate with and authenticate to the backing data store.")
  source: Source;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

// Source Properties
@discriminator("type")
@doc("The type of backing data source")
model Source {
  @doc("Type of the Storage Connector - Bucket. Not mutable once the Storage Connector is created.")
  type: SourceType;
}

// DataShare Source Properties
@doc("The properties of the backing data store.")
@added(Versions.v2025_07_01_preview)
model DataShareSource extends Source {
  @visibility(Lifecycle.Read)
  type: SourceType.DataShare;

  @doc("Details for how to connect to the backing data store.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  connection: Connection;

  @doc("Details for how to authenticate to the backing data store.")
  authProperties: AuthProperties;
}

// Connection Properties
@discriminator("type")
@doc("Details related to the type of bucket connection")
model Connection {
  @doc("Type of the connection - Endpoint or PrivateLink. Controls the type of the connection object. Not mutable once the Storage Connector is created.")
  type: ConnectionType;
}

// DataShare Connection Properties
@doc("Details related to DataShare based connection")
@added(Versions.v2025_07_01_preview)
model DataShareConnection extends Connection {
  @visibility(Lifecycle.Read)
  type: ConnectionType.DataShare;

  @doc("The URI of the backing DataShare. Must be in the format: azds://<region>:<DataShareName>:<DataShareIdentifier>")
  @pattern("^azds://[a-zA-Z0-9-]+:[a-zA-Z0-9-_]+:[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  dataShareUri: string;
}

// Auth Properties
@discriminator("type")
@doc("The auth properties for bucket connection.")
model AuthProperties {
  @doc("The auth type for bucket connection.")
  type: AuthType;
}

// Managed Identity Auth Properties
@doc("The managed identity properties for dataShare connection.")
@added(Versions.v2025_07_01_preview)
model ManagedIdentityAuthProperties extends AuthProperties {
  @visibility(Lifecycle.Read)
  type: AuthType.ManagedIdentity;

  @doc("ARM ID of the managed identity that should be used to authenticate to the backing data source.")
  identityResourceId?: string;
}

// Test Existing Connection request
@doc("The test connection related properties.")
model TestExistingConnectionRequest {
  @doc("The uniqueId of the connector as returned by the server.")
  uniqueId: string;
}

// Test connection response
@doc("The test connection response")
model TestConnectionResponse {
  @doc("Indicates the method used to validate the connection to the backing data store. Valid values are `GetBlob` and `ListBlobs` for failure, and `TestExistingConnection` for success.")
  @minLength(1)
  storageConnectorMethodName: string;

  @doc("A string representing the error received from the backing data store. Format will vary depending on the data store type and will be capped at 1 MB in size. The error message will be empty if the connection was successful.")
  storageConnectorErrorMessage?: string;

  @doc("The request Id associated with the request sent to the backing data store for validation.")
  @minLength(1)
  storageConnectorRequestId: string;
}
