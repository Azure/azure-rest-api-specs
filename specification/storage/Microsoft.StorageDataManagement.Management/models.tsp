import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Storage;

// Connector Properties
@doc("Details of the Storage Connector.")
model ConnectorProperties {
  @visibility("read")
  @doc("System-generated identifier for the Storage Connector. Not a valid input parameter when creating.")
  uniqueId?: string;

  @doc("State - Enabled or Disabled. Whether or not the Storage Connector should start as enabled (default: Enabled) (While set to false on the Storage Connector, all data plane requests using this Storage Connector fail, and this Storage Connector is not billed if it would be otherwise.)")
  state?: State = State.Enabled;

  @visibility("read")
  @doc("System-generated creation time for the Storage Connector. Not a valid input parameter when creating.")
  creationTime?: string;

  @doc("Arbitrary description of this Storage Connector. Max 250 characters.")
  @maxLength(250)
  description?: string;

  @visibility("create")
  @doc("Test connection to backing data source before creating the storage connector.")
  testConnection?: boolean = false;

  @visibility("create")
  @doc("The source of the backing data source.")
  dataSourceType: DataSourceType;

  @doc("Information about how to communicate with and authenticate to the backing data store.")
  source: Source;

  @visibility("read")
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

@doc("The properties of the backing data store.")
model BucketSource extends Source {
  @visibility("read")
  type: SourceType.Bucket;

  @doc("Details for how to connect to the backing data store.")
  connection: Connection;

  @doc("Details for how to authenticate to the backing data store.")
  authProperties: AuthProperties;

  @doc("The host to use when computing the signature for requests to the backing data store. If not provided, defaults to what is provided in the endpoint for the connection.")
  hostOverride?: string;
}

// Connection Properties
@discriminator("type")
@doc("Details related to the type of bucket connection")
model Connection {
  @doc("Type of the connection - Endpoint or PrivateLink. Controls the type of the connection object.")
  type: ConnectionType;
}

@doc("Details related to endpoint based bucket connection")
model EndpointConnection extends Connection {
  @visibility("read")
  type: ConnectionType.Endpoint;

  @doc("Endpoint to connect to, including the protocol (http vs https), the host name, the port if applicable (defaulting to 80 or 443), and the path if applicable. Samples: https://203.0.113.1:9000/AllowSelfSignedCerts Bucket: https://data.contoso.com/bucketname .")
  @minLength(4)
  endpoint: string;

  @doc("Options - Perform or Skip (default: Perform)  If this is set to “Skip”, Azure Storage will not verify the certificate chain of TLS connections to a root CA. Set this to “Skip” if the backing data store uses a self-signed cert. Ignored if the endpoint field does not use HTTPS.")
  tlsVerification?: TlsVerification = TlsVerification.Perform;
}

// Auth Properties
@discriminator("type")
@doc("The auth properties for bucket connection.")
model AuthProperties {
  type: AuthType;
}

@doc("The access key properties for bucket connection.")
model AccessKeyProperties extends AuthProperties {
  @visibility("read")
  type: AuthType.AccessKey;

  @doc("Access key ID for the backing data store.")
  @minLength(3)
  accessKeyId: string;

  @doc("Secret access key. Redacted when read via a Get or List API.")
  @secret
  @minLength(3)
  secretAccessKey: string;

  @doc("Region to use in the signing algorithm.  If not provided, defaults to us-east-1.")
  signingRegion?: string;
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
  @doc("Which request attempt failed. Valid values are List and GetBlob.")
  @minLength(1)
  storageConnectorMethodName: string;

  @doc("A string representing the error received from the backing data store. Format will vary depending on the data store type.  This will be capped at 1 MB in size.")
  @minLength(1)
  storageConnectorErrorMessage: string;

  @doc("The request ID associated with the request sent to the backing data store for validation.")
  @minLength(1)
  storageConnectorRequestId: string;
}
