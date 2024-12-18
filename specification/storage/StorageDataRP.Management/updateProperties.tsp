import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.StorageDataRp;

@doc("The auth properties for bucket connection.")
model UpdateAuthProperties {
  @doc("Authentication type to be used. Allowed values are AccessKey")
  type?: AuthType;

  @doc("Access key ID for the backing data store.")
  accessKeyId?: string;

  @doc("Secret access key. Redacted when read via a Get or List API.")
  secretAccessKey?: string;

  @doc("Region to use in the signing algorithm.  If not provided, defaults to us-east-1.")
  signingRegion?: string;
}

@doc("Details related to the type of bucket connection")
model UpdateConnection {
  @doc("Type of the connection – Endpoint or PrivateLink. Controls the type of the connection object.")
  type?: ConnectionType;

  @doc("Endpoint to connect to, including the protocol (http vs https), the host name, the port if applicable (defaulting to 80 or 443), and the path if applicable. Samples: https://203.0.113.1:9000/AllowSelfSignedCerts Bucket: https://data.contoso.com/bucketname .")
  endpoint: string;

  @doc("Options – Resource Id or Alias. Determines whether the “privateLinkId” field is an ARM Resource ID of a Private Link, or a Private Link alias.")
  privateLinkIdType?: PrivateLinkIdType;

  @doc("The identifier of the Private Link resource, over which the backing data store can be accessed. Depending on the “privateLinkIdType”, should either be an ARM Resource ID or an Private Link alias.")
  privateLinkId?: string;

  @doc("The group Id of the privatelink resource")
  privateLinkGroupId?: string;

  @doc("Azure region of the private link.")
  privateLinkLocation?: string;

  @doc("The message to send to the owner of the private link via a manual request, when Azure Storage is creating a Private Endpoint to communicate with the Private Link.")
  requestMessage?: string;

  @visibility("read")
  @doc("Options – Approved or Disconnected or Pending or Rejected or Timeout. Not settable by callers. The state of the connection to the Private Link resource.")
  privateLinkStatus?: PrivateLinkStatus;

  @doc("Options – Perform or Skip (default: Perform)  If this is set to “Skip”, Azure Storage will not verify the certificate chain of TLS connections to a root CA. Set this to “Skip” if the backing data store uses a self-signed cert. Ignored if the endpoint field does not use HTTPS.")
  tlsVerification?: TlsVerification;
}

@doc("The type of backing data source")
model UpdateSource {
  @doc("Type of the Storage Connector – Bucket. Not mutable once the Storage Connector is created.")
  type?: SourceType;

  @doc("Details for how to connect to the backing data store.")
  connection?: UpdateConnection;

  @doc("Details for how to authenticate to the backing data store.")
  authProperties?: UpdateAuthProperties;

  @doc("The host to use when computing the signature for requests to the backing data store. If not provided, defaults to what is provided in the endpoint for the connection.")
  hostOverride?: string;
}

@doc("Update properties for connector resource")
model ConnectorUpdateProps {
  @doc("State – Enabled or Disabled. Whether or not the Storage Connector should start as enabled (default: Enabled) (While set to false on the Storage Connector, all data plane requests using this Storage Connector fail, and this Storage Connector is not billed if it would be otherwise.)")
  state?: State;

  @doc("Arbitrary description of this Storage Connector. Max 250 characters.")
  @maxLength(250)
  description?: string;

  @doc("Information about how to communicate with and authenticate to the backing data store.")
  source?: UpdateSource;
}

@doc("Patchable Connector model")
model PatchableConnector {
  @doc("Patchable Connector Properties")
  properties?: ConnectorUpdateProps;
}
