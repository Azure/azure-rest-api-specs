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

  @doc("Source type - DataShare")
  @added(Versions.v2025_07_01_preview)
  DataShare: "DataShare",

  string,
}

@doc("The state of the connector")
union State {
  @doc("Whether the connector is active")
  Active: "Active",

  @doc("Whether the connector is inactive")
  Inactive: "Inactive",

  string,
}

@doc("The auth type supported for bucket connection.")
union AuthType {
  @doc("Access Key auth type")
  AccessKey: "AccessKey",

  @doc("Managed Identity auth type")
  @added(Versions.v2025_07_01_preview)
  ManagedIdentity: "ManagedIdentity",

  string,
}

@doc("The connection type for bucket connection")
union ConnectionType {
  @doc("Endpoint connection type")
  Endpoint: "Endpoint",

  @doc("PrivateLink connection type")
  @added(Versions.v2025_05_01_preview)
  PrivateLink: "PrivateLink",

  @doc("DataShare connection type")
  @added(Versions.v2025_07_01_preview)
  DataShare: "DataShare",

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

  @doc("Azure DataShare data source type.")
  @added(Versions.v2025_07_01_preview)
  Azure_DataShare: "Azure_DataShare",

  string,
}

@doc("The permissions supported in access policies")
@added(Versions.v2025_07_01_preview)
union AccessPolicyPermission {
  @doc("No permission")
  None: "None",

  @doc("Read permission")
  Read: "Read",

  string,
}
