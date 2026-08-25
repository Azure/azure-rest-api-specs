import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./StorageAccount.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Storage;

@added(Versions.v2026_09_01)
@doc("The state of a Blob Access Point configuration.")
union BlobAccessPointConfigurationState {
  @doc("The Blob Access Point configuration is active.")
  Active: "Active",

  @doc("The Blob Access Point configuration is inactive.")
  Inactive: "Inactive",

  string,
}

@added(Versions.v2026_09_01)
@doc("The status of the most recent connection test.")
union BlobAccessPointConnectionTestStatus {
  @doc("The connection test succeeded.")
  Succeeded: "Succeeded",

  @doc("The connection test failed.")
  Failed: "Failed",

  string,
}

@added(Versions.v2026_09_01)
@doc("The type of the non-Azure S3-compatible data source exposed through the Blob Access Point.")
union BlobAccessPointSourceType {
  @doc("NetApp ONTAP.")
  NetAppOntap: "NetAppOntap",

  @doc("Azure NetApp Files.")
  AzureNetAppFiles: "AzureNetAppFiles",

  @doc("Dell OneFS.")
  DellOneFs: "DellOneFs",

  @doc("Qumulo S3-compatible data source.")
  Qumulo: "Qumulo",

  @doc("Commvault S3-compatible data source.")
  Commvault: "Commvault",

  @doc("Nasuni S3-compatible data source.")
  Nasuni: "Nasuni",

  @doc("Another S3-compatible data source.")
  S3Compatible: "S3Compatible",

  string,
}

@added(Versions.v2026_09_01)
@doc("The connection type used to reach a non-Azure backing data source.")
union BlobAccessPointConnectionType {
  @doc("Connect directly to a public or otherwise routable endpoint.")
  Endpoint: "Endpoint",

  @doc("Connect through Azure Private Link.")
  PrivateLink: "PrivateLink",

  string,
}

@added(Versions.v2026_09_01)
@doc("The format used by a Private Link identifier.")
union BlobAccessPointPrivateLinkIdType {
  @doc("The identifier is an Azure resource ID.")
  ResourceId: "ResourceId",

  @doc("The identifier is a Private Link alias.")
  Alias: "Alias",

  string,
}

@added(Versions.v2026_09_01)
@doc("TLS certificate verification behavior.")
union BlobAccessPointTlsVerification {
  @doc("Verify the TLS certificate chain.")
  Perform: "Perform",

  @doc("Skip TLS certificate-chain verification. Use only when the backing source uses a certificate that cannot be validated against a trusted root. Skipping verification exposes credentials and data to an on-path attacker.")
  Skip: "Skip",

  string,
}

@added(Versions.v2026_09_01)
@doc("How Azure Storage authenticates to a non-Azure S3-compatible source.")
union BlobAccessPointRemoteAuthType {
  @doc("Authenticate with an S3 access key and secret access key.")
  AccessKey: "AccessKey",

  string,
}

@added(Versions.v2026_09_01)
@discriminator("connectionType")
@doc("Details for connecting to a backing data source.")
model BlobAccessPointConnectionProperties {
  @doc("The connection type. This value determines the remaining shape of the connection object.")
  connectionType: BlobAccessPointConnectionType;
}

@added(Versions.v2026_09_01)
@doc("A direct endpoint connection.")
model BlobAccessPointEndpointConnectionProperties
  extends BlobAccessPointConnectionProperties {
  @visibility(Lifecycle.Read)
  connectionType: BlobAccessPointConnectionType.Endpoint;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The backing endpoint, including its protocol, host, optional port, and optional path.")
  @minLength(4)
  endpoint: url;

  @doc("TLS certificate verification behavior. Defaults to Perform when not specified.")
  tlsVerification?: BlobAccessPointTlsVerification;
}

@added(Versions.v2026_09_01)
@doc("A connection established through Azure Private Link.")
model BlobAccessPointPrivateLinkConnectionProperties
  extends BlobAccessPointConnectionProperties {
  @visibility(Lifecycle.Read)
  connectionType: BlobAccessPointConnectionType.PrivateLink;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Whether privateLinkId contains an Azure resource ID or a Private Link alias.")
  privateLinkIdType: BlobAccessPointPrivateLinkIdType;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The Azure resource ID or alias of the backing Private Link resource.")
  privateLinkId: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The Private Link group ID, when required by the backing resource.")
  privateLinkGroupId?: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The Azure region in which the private endpoint is provisioned.")
  privateLinkLocation: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The connection request message sent to the Private Link owner.")
  requestMessage: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The backing endpoint as seen by the target of the Private Link.")
  @minLength(4)
  endpoint: url;

  @doc("TLS certificate verification behavior. Defaults to Perform when not specified.")
  tlsVerification?: BlobAccessPointTlsVerification;

  @visibility(Lifecycle.Read)
  @doc("The name of the private endpoint created by Azure Storage.")
  privateEndpointName?: string;
}

@added(Versions.v2026_09_01)
@discriminator("authType")
@doc("Authentication properties for a non-Azure S3-compatible source.")
model BlobAccessPointRemoteAuthProperties {
  @doc("The authentication type. This value determines the remaining shape of the authentication object.")
  authType: BlobAccessPointRemoteAuthType;
}

@added(Versions.v2026_09_01)
@doc("S3 access-key authentication properties.")
model BlobAccessPointAccessKeyAuthProperties
  extends BlobAccessPointRemoteAuthProperties {
  @visibility(Lifecycle.Read)
  authType: BlobAccessPointRemoteAuthType.AccessKey;

  @minLength(3)
  @doc("The access key ID.")
  accessKeyId: string;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  @minLength(3)
  @doc("The secret access key. This value is never returned by read or list operations.")
  secretAccessKey: string;

  @doc("The region used by the request-signing algorithm. Defaults to 'us-east-1' when not specified.")
  signingRegion?: string;

  @doc("The host used when computing request signatures. The endpoint host is used by default.")
  hostOverride?: string;
}

@added(Versions.v2026_09_01)
@discriminator("sourceType")
@doc("Information about the data source exposed through a Blob Access Point.")
model BlobAccessPointSourceProperties {
  @doc("The source type. This value determines the remaining shape of the source object.")
  sourceType: BlobAccessPointSourceType;
}

/** Properties shared by every non-Azure S3-compatible backing source. */
alias BlobAccessPointS3CompatibleSourceProperties = {
  @doc("Details for connecting to the backing data source. The connection target is fixed when the configuration is created; only the TLS verification behavior can be changed afterwards.")
  connection: BlobAccessPointConnectionProperties;

  @doc("Details for authenticating to the backing data source.")
  auth: BlobAccessPointRemoteAuthProperties;
};

@added(Versions.v2026_09_01)
@doc("A NetApp ONTAP backing source.")
model BlobAccessPointNetAppOntapSourceProperties
  extends BlobAccessPointSourceProperties {
  @visibility(Lifecycle.Read)
  sourceType: BlobAccessPointSourceType.NetAppOntap;

  ...BlobAccessPointS3CompatibleSourceProperties;
}

@added(Versions.v2026_09_01)
@doc("An Azure NetApp Files backing source.")
model BlobAccessPointAzureNetAppFilesSourceProperties
  extends BlobAccessPointSourceProperties {
  @visibility(Lifecycle.Read)
  sourceType: BlobAccessPointSourceType.AzureNetAppFiles;

  ...BlobAccessPointS3CompatibleSourceProperties;
}

@added(Versions.v2026_09_01)
@doc("A Dell OneFS backing source.")
model BlobAccessPointDellOneFsSourceProperties
  extends BlobAccessPointSourceProperties {
  @visibility(Lifecycle.Read)
  sourceType: BlobAccessPointSourceType.DellOneFs;

  ...BlobAccessPointS3CompatibleSourceProperties;
}

@added(Versions.v2026_09_01)
@doc("A Qumulo backing source.")
model BlobAccessPointQumuloSourceProperties
  extends BlobAccessPointSourceProperties {
  @visibility(Lifecycle.Read)
  sourceType: BlobAccessPointSourceType.Qumulo;

  ...BlobAccessPointS3CompatibleSourceProperties;
}

@added(Versions.v2026_09_01)
@doc("A Commvault backing source.")
model BlobAccessPointCommvaultSourceProperties
  extends BlobAccessPointSourceProperties {
  @visibility(Lifecycle.Read)
  sourceType: BlobAccessPointSourceType.Commvault;

  ...BlobAccessPointS3CompatibleSourceProperties;
}

@added(Versions.v2026_09_01)
@doc("A Nasuni backing source.")
model BlobAccessPointNasuniSourceProperties
  extends BlobAccessPointSourceProperties {
  @visibility(Lifecycle.Read)
  sourceType: BlobAccessPointSourceType.Nasuni;

  ...BlobAccessPointS3CompatibleSourceProperties;
}

@added(Versions.v2026_09_01)
@doc("Another S3-compatible backing source.")
model BlobAccessPointGenericS3SourceProperties
  extends BlobAccessPointSourceProperties {
  @visibility(Lifecycle.Read)
  sourceType: BlobAccessPointSourceType.S3Compatible;

  ...BlobAccessPointS3CompatibleSourceProperties;
}

@added(Versions.v2026_09_01)
@doc("Details of a Blob Access Point configuration.")
model BlobAccessPointConfigurationProperties {
  @visibility(Lifecycle.Read)
  @doc("The system-generated unique identifier of the configuration.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  uniqueId?: string;

  @doc("The configuration state. A configuration is created in the Active state when this value is not specified.")
  state?: BlobAccessPointConfigurationState;

  @maxLength(250)
  @doc("An arbitrary description of the Blob Access Point configuration.")
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the most recent connection test.")
  lastConnectionTestStatus?: BlobAccessPointConnectionTestStatus;

  @visibility(Lifecycle.Read)
  @doc("The timestamp of the most recent connection test.")
  lastConnectionTestTimestamp?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The normalized and redacted error from the most recent failed connection test.")
  lastConnectionTestErrorMessage?: string;

  @doc("Information about the backing data source.")
  source: BlobAccessPointSourceProperties;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
}

@added(Versions.v2026_09_01)
@doc("The result of testing a Blob Access Point configuration connection.")
model BlobAccessPointConnectionTestResponse {
  @doc("The name of the request attempted against the backing data source.")
  @minLength(1)
  methodName: string;

  @doc("A normalized and redacted error message received from the backing data source. This value is empty when the connection test succeeds.")
  errorMessage?: string;

  @doc("The request ID associated with the request sent to the backing data source for validation.")
  @minLength(1)
  requestId: string;
}

@added(Versions.v2026_09_01)
@doc("The request used to test a proposed Blob Access Point configuration.")
model BlobAccessPointProposedConnectionTestRequest {
  @doc("Information about the backing data source whose connection is tested.")
  source: BlobAccessPointSourceProperties;
}

@added(Versions.v2026_09_01)
@doc("The request used to test an existing Blob Access Point configuration.")
model BlobAccessPointConnectionTestRequest {
  @doc("The system-generated unique identifier of the Blob Access Point configuration, as returned by a read operation. This value must match the configuration named in the request path, and is required so that a configuration which was deleted and recreated under the same name is not tested by mistake.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  uniqueId: string;
}

@added(Versions.v2026_09_01)
@doc("A BlobAccessPointConfiguration is a tracked Azure resource modeled as a sub-resource of a Storage Account.")
@parentResource(StorageAccount)
model BlobAccessPointConfiguration is TrackedResource<
  BlobAccessPointConfigurationProperties,
  false
> {
  @doc("The name of the Blob Access Point configuration.")
  @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
  @key("blobAccessPointConfigurationName")
  @segment("blobAccessPointConfigurations")
  @path
  name: string;
}

@armResourceOperations(BlobAccessPointConfiguration)
interface BlobAccessPointConfigurations {
  @doc("Get the specified Blob Access Point configuration.")
  @added(Versions.v2026_09_01)
  get is ArmResourceRead<BlobAccessPointConfiguration>;

  @doc("Creates or updates a Blob Access Point configuration.")
  @added(Versions.v2026_09_01)
  create is ArmResourceCreateOrReplaceAsync<BlobAccessPointConfiguration>;

  @doc("Update a Blob Access Point configuration.")
  @added(Versions.v2026_09_01)
  update is ArmResourcePatchAsync<
    BlobAccessPointConfiguration,
    BlobAccessPointConfigurationProperties,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = BlobAccessPointConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Delete a Blob Access Point configuration.")
  @added(Versions.v2026_09_01)
  delete is ArmResourceDeleteWithoutOkAsync<
    BlobAccessPointConfiguration,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("List all Blob Access Point configurations in a Storage Account.")
  @added(Versions.v2026_09_01)
  listByStorageAccount is ArmResourceListByParent<BlobAccessPointConfiguration>;

  @doc("Test the connection configured on an existing Blob Access Point configuration.")
  @added(Versions.v2026_09_01)
  testExistingConnection is ArmResourceActionAsync<
    BlobAccessPointConfiguration,
    BlobAccessPointConnectionTestRequest,
    BlobAccessPointConnectionTestResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = BlobAccessPointConnectionTestResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@armResourceOperations(StorageAccount)
interface BlobAccessPointConnectionTests {
  @doc("Test a proposed Blob Access Point connection before the configuration is created. The connection is validated in the context of the storage account in the request path, so no Blob Access Point configuration needs to exist beforehand.")
  @added(Versions.v2026_09_01)
  @action("testBlobAccessPointConfigurationProposedConnection")
  testProposedConnection is ArmResourceActionAsync<
    StorageAccount,
    BlobAccessPointProposedConnectionTestRequest,
    BlobAccessPointConnectionTestResponse,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = BlobAccessPointConnectionTestResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
