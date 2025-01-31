import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Storage;

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,
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

@doc("The connection type for bucket connection")
union ConnectionType {
  @doc("Endpoint connection type")
  Endpoint: "Endpoint",

  string,
}

@doc("The TLS Verification options")
union TlsVerification {
  @doc("Perform TLS Verification")
  Perform: "Perform",

  @doc("Use AllowSelfSignedCerts as TlsVerification")
  AllowSelfSignedCerts: "AllowSelfSignedCerts",

  string,
}

@doc("The type of the backing data source.")
union DataSourceType {
  @doc("NetApp ONTAP data source type.")
  NetApp_ONTAP: "NetApp_ONTAP",

  @doc("Azure NetApp Files data source type.")
  Azure_NetApp_Files: "Azure_NetApp_Files",

  @doc("Dell OneFS data source type.")
  Dell_OneFS: "Dell_OneFS",

  @doc("AWS S3 data source type.")
  AWS_S3: "AWS_S3",

  @doc("S3 Compatible data source type.")
  S3_Compatible: "S3_Compatible",

  string,
}
