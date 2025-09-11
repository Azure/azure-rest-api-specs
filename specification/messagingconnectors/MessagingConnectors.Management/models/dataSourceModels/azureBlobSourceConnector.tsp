import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.AzureBlob;

@doc("Type of File Compression Mode")
union AzureBlobCompression {
  @doc("Not Compressed")
  None: "None",

  @doc("Gzip Compression")
  Gzip: "Gzip",

  string,
}

@doc("Configuration for AzureBlobSourceConnector")
model AzureBlobSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of AzureBlobSourceConnector")
  connectorType: Models.Connector.ConnectorType.AzureBlobSource;

  @doc("The name of the storage account where the blob files are located")
  accountName: string;

  @doc("Authentication for AzureBlob")
  authentication: Models.Auth.Authentication;

  @doc("Container name")
  containerName: string;

  @doc("The path pattern to locate the files, default to * to poll all")
  pathPattern?: string;

  @doc("Compression type")
  compression?: AzureBlobCompression;

  @doc("the datetime to start processing files, files whose creation time earlier than this will be ignored")
  discoveryDateTime?: utcDateTime;

  @doc("Date format of {date} variable in path pattern")
  pathDateFormat?: string;

  @doc("Time format of {time} variable in path pattern, support only hours currently")
  pathTimeFormat?: string;

  @doc("For how many hours late that we still consider a file to be on time")
  outOfOrderHours?: int32;
}
