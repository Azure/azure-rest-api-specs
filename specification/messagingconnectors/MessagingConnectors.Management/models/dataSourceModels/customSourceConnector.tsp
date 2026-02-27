import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.CustomConnector;

@doc("Package storage information model.")
model PackageStorageInformation {
  @doc("Path for package.")
  blobPath: string;

  @doc("Authentication for package storage, OAuth or ConnectionString.")
  authentication: Models.Auth.Authentication;
}

@doc("Property definition for custom connector.")
model CustomConnectorProperty {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "not a secret"
  @doc("Property key.")
  key: string;

  @doc("Property value.")
  value: string;

  @doc("Whether this is one secret property, default is false.")
  isSecret?: boolean;
}

@doc("Configuration for CustomSourceConnector")
model CustomSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of CustomSourceConnector")
  connectorType: Models.Connector.ConnectorType.CustomConnectorSource;

  @doc("Id used for isolation.")
  isolationId: string;

  @doc("Class name for connector in jar package.")
  className: string;

  @doc("Package storage information for jar package.")
  packageStorageInformation: PackageStorageInformation;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Array list of properties.")
  properties: CustomConnectorProperty[];
}
