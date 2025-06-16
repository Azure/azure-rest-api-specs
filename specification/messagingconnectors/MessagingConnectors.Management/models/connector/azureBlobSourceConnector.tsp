import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@added(Versions.v2025_05_01_preview)
@doc("Type of File Compression Mode")
union Compression {
  @doc("Not Compressed")
  None: "None",

  @doc("Gzip Compression")
  Gzip: "Gzip",

  string,
}

@added(Versions.v2025_05_01_preview)
@doc("Configuration for AzureBlobSourceConnector")
model AzureBlobSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of AzureBlobSourceConnector")
  connectorType: ConnectorType.AzureBlobSource;

  @doc("The name of the storage account where the blob files are located")
  accountName: string;

  @doc("Authentication for AzureBlob")
  authentication: Authentication;

  @doc("Container name")
  containerName: string;

  @doc("The path pattern to locate the files, default to * to poll all")
  pathPattern?: string;

  @doc("Compression type")
  compression?: Compression;

  @doc("the datetime to start processing files, files whose creation time earlier than this will be ignored")
  discoveryDateTime?: utcDateTime;

  @doc("Date format of {date} variable in path pattern")
  pathDateFormat?: string;

  @doc("Time format of {time} variable in path pattern, support only hours currently")
  pathTimeFormat?: string;

  @doc("For how many hours late that we still consider a file to be on time")
  outOfOrderHours?: int32;
}
