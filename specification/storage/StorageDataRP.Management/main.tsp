import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Storage")
@service({
  title: "Storage Data Resource Provider",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Storage;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-11-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Connector is a tracked ARM resource modeled as a sub-resource of a Storage Account")
model Connector is TrackedResource<ConnectorProperties> {
  @doc("The name of the connector")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("connectorName")
  @segment("connectors")
  @path
  name: string;
}

@armResourceOperations(Connector)
interface Connectors {
  @doc("Get the specified Storage Connector.")
  get is ArmResourceRead<Connector>;

  @doc("Create or update a Storage Connector.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Connector>;

  @doc("Update a Storage Connector.")
  update is ArmCustomPatchAsync<
    Connector,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Connector,
      ConnectorProperties
    >
  >;

  @doc("Delete a Storage Connector.")
  delete is ArmResourceDeleteSync<Connector>;

  @doc("List all Storage Connectors in a Storage Account.")
  listByStorageAccount is ArmResourceListByParent<Connector>;

  @doc("This method is used to verify that the connection to the backing data store works. This API is designed to be used for monitoring and debugging purposes. From the caller’s perspective, this method does the following: Calls List on the backing data store, attempting to list up to one blob/object/etc. If the above succeeds, and if a blob/object/etc is found, calls Get on that object, attempting to download one byte.")
  existingConnectionTest is ArmResourceActionSync<
    Connector,
    ExistingConnectionTestRequest,
    TestConnectionResponse
  >;

  @doc("This method is used to verify that a proposed connection to the backing data store will work, if Create Connector is called with the same Connector information provided in the body of this API request. This API is designed to be used in the initialization flow, where a new user would call Storage Connector Test Proposed Connection, and upon getting a successful response, then call Storage Connector Create with the same input.  See above API “Storage Connectors – Test Existing Connection” for an API designed to be called for monitoring and debugging, once a Connector is created.")
  proposedConnectionTest is ArmResourceActionSync<
    Connector,
    Connector,
    TestConnectionResponse
  >;
}

@doc("The test connection related properties.")
model ExistingConnectionTestRequest {
  @doc("The uniqueId of the connector as returned by the server.")
  uniqueId: string;
}

@doc("The test connection response")
model TestConnectionResponse {
  @doc("Which request attempt failed. Valid values are List and GetBlob.")
  storageConnectorMethodName: string;

  @doc("A string representing the error received from the backing data store. Format will vary depending on the data store type.  This will be capped at 1 MB in size.")
  storageConnectorErrorMessage: string;

  @doc("The request ID associated with the request sent to the backing data store for validation.")
  storageConnectorRequestId: string;
}

// New models and enums for the requested resource

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}

@doc("The type of the backing data source")
union SourceType {
  @doc("Source type - Bucket")
  Bucket: "Bucket",

  string,
}

@doc("The state of the connector")
union State {
  @doc("Whether the connector is enabled")
  Enabled: "Enabled",

  @doc("Whether the connector is disabled")
  Disabled: "Disabled",

  string,
}

@doc("The auth type supported for bucket connection.")
union AuthType {
  @doc("Access Key auth type")
  AccessKey: "AccessKey",

  string,
}

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
  accessKeyId: string;

  @doc("Secret access key. Redacted when read via a Get or List API.")
  secretAccessKey: string;

  @doc("Region to use in the signing algorithm.  If not provided, defaults to us-east-1.")
  signingRegion?: string;
}

@doc("The connection type for bucket connection")
union ConnectionType {
  @doc("Endpoint connection type")
  Endpoint: "Endpoint",

  @doc("Private Link connection type")
  PrivateLink: "PrivateLink",

  string,
}

@discriminator("type")
@doc("Details related to the type of bucket connection")
model Connection {
  @doc("Type of the connection – Endpoint or PrivateLink. Controls the type of the connection object.")
  type: ConnectionType;
}

@doc("The TLS Verification options")
union TlsVerification {
  @doc("Perform TLS Verification")
  Perform: "Perform",

  @doc("Use AllowSelfSignedCerts as TlsVerification")
  AllowSelfSignedCerts: "AllowSelfSignedCerts",

  string,
}

@doc("Details related to endpoint based bucket connection")
model EndpointConnection extends Connection {
  @visibility("read")
  type: ConnectionType.Endpoint;

  @doc("Endpoint to connect to, including the protocol (http vs https), the host name, the port if applicable (defaulting to 80 or 443), and the path if applicable. Samples: https://203.0.113.1:9000/AllowSelfSignedCerts Bucket: https://data.contoso.com/bucketname .")
  endpoint: string;

  @doc("Options – Perform or Skip (default: Perform)  If this is set to “Skip”, Azure Storage will not verify the certificate chain of TLS connections to a root CA. Set this to “Skip” if the backing data store uses a self-signed cert. Ignored if the endpoint field does not use HTTPS.")
  tlsVerification?: TlsVerification = TlsVerification.Perform;
}

@doc("The supported PrivateLinkId types")
union PrivateLinkIdType {
  @doc("ResourceId for PrivateLink ID")
  ResourceId: "ResourceId",

  @doc("Alias for Private Link")
  Alias: "Alias",

  string,
}

@doc("The status of the private link")
union PrivateLinkStatus {
  @doc("Private Link in pending")
  Pending: "Pending",

  @doc("Private Link is approved")
  Approved: "Approved",

  @doc("Private Link in rejected")
  Rejected: "Rejected",

  @doc("Private Link is disconnected")
  Disconnected: "Disconnected",

  @doc("Private Link Provisioning timed out")
  Timeout: "Timeout",

  string,
}

@doc("Details related to private link based bucket connection")
model PrivateLinkConnection extends Connection {
  @visibility("read")
  type: ConnectionType.PrivateLink;

  @doc("Options – Resource Id or Alias. Determines whether the “privateLinkId” field is an ARM Resource ID of a Private Link, or a Private Link alias.")
  privateLinkIdType: PrivateLinkIdType;

  @doc("The identifier of the Private Link resource, over which the backing data store can be accessed. Depending on the “privateLinkIdType”, should either be an ARM Resource ID or an Private Link alias.")
  privateLinkId: string;

  privateLinkGroupId: string;

  @doc("Azure region of the private link.")
  privateLinkLocation: string;

  @doc("The message to send to the owner of the private link via a manual request, when Azure Storage is creating a Private Endpoint to communicate with the Private Link.")
  requestMessage: string;

  @visibility("read")
  @doc("Options – Approved or Disconnected or Pending or Rejected or Timeout. Not settable by callers. The state of the connection to the Private Link resource.")
  privateLinkStatus: PrivateLinkStatus;

  @doc("Endpoint to connect to, including the protocol (http vs https), the host name, the port if applicable (defaulting to 80 or 443), and the path if applicable. Samples: Storage Account: https://myaccount.blob.core.windows.net/containername Bucket: https://data.contoso.com/bucketname Note that this will be the endpoint as seen by the target of the Private Link in HTTP(s) requests. It is not a Private Endpoint used to connect to the Private Link.")
  endpoint: string;

  @doc("Options – Perform or Skip (default: Perform)  If this is set to “Skip”, Azure Storage will not verify the certificate chain of TLS connections to a root CA. Set this to “Skip” if the backing data store uses a self-signed cert. Ignored if the endpoint field does not use HTTPS.")
  tlsVerification?: TlsVerification = TlsVerification.Perform;
}

@discriminator("type")
@doc("The type of backing data source")
model Source {
  @doc("Type of the Storage Connector – Bucket. Not mutable once the Storage Connector is created.")
  type?: SourceType;
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

@doc("Details of the Storage Connector.")
model ConnectorProperties {
  @visibility("read")
  @doc("System-generated identifier for the Storage Connector. Not a valid input parameter when creating.")
  uniqueId?: string;

  @doc("State – Enabled or Disabled. Whether or not the Storage Connector should start as enabled (default: Enabled) (While set to false on the Storage Connector, all data plane requests using this Storage Connector fail, and this Storage Connector is not billed if it would be otherwise.)")
  state?: State = State.Enabled;

  @visibility("read")
  @doc("System-generated creation time for the Storage Connector. Not a valid input parameter when creating.")
  creationTime?: string;

  @doc("Arbitrary description of this Storage Connector. Max 250 characters.")
  @maxLength(250)
  description?: string;

  @doc("Information about how to communicate with and authenticate to the backing data store.")
  source: Source;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
