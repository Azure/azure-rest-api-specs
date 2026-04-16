import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../fileReference.tsp";

namespace Microsoft.MessagingConnectors.Models.Manifest;

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Properties of the manifest resource.")
model ManifestProperties {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Request for getting connector manifest.")
model GetConnectorManifestRequest {
  @doc("The connector type.")
  connectorType: string;
}

@doc("Result of getting connector manifest.")
model GetConnectorManifestResult {
  @doc("The connector manifest.")
  connectorManifest: ConnectorManifest;
}

@doc("Connector manifest information.")
model ConnectorManifest {
  @Azure.ResourceManager.identifiers(#[])
  @doc("Array of config key information.")
  configKeysInformations: ConfigKeyInformation[];

  @doc("Whether data preview is supported.")
  isDataPreviewSupported: boolean;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Request for getting custom connector configuration definition.")
model GetCustomConnectorConfigurationDefRequest {
  @doc("Id used for isolation.")
  isolationId: string;

  @doc("Package storage information for jar package.")
  packageStorageInformation: Models.DataSource.CustomConnector.PackageStorageInformation;
}

@doc("Result of getting custom connector configuration definition.")
model GetCustomConnectorConfigurationDefResult {
  @Azure.ResourceManager.identifiers(#[])
  @doc("Array of configuration definitions.")
  configurationDefs: ConfigurationDef[];
}

@doc("Property of configuration definition.")
model ConfigurationDef {
  @doc("Class name in package.")
  className: string;

  @doc("Class plugin type.")
  pluginType: PluginType;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Array of config key information.")
  configKeysInformations: ConfigKeyInformation[];
}

@doc("Enum of the type of Kafka Connect plugin.")
union PluginType {
  @doc("This represents a Kafka Connect source connector plugin.")
  SourceConnector: "SourceConnector",

  @doc("This represents a Kafka Connect sink connector plugin.")
  SinkConnector: "SinkConnector",

  @doc("This represents a Kafka Connect transform plugin.")
  Transform: "Transform",

  @doc("This represents a Kafka Connect converter plugin.")
  Converter: "Converter",

  string,
}

@doc("Type of configuration key.")
union ConfigKeyInfoType {
  @doc("BOOLEAN type.")
  BOOLEAN: "BOOLEAN",

  @doc("CLASS type.")
  CLASS: "CLASS",

  @doc("DOUBLE type.")
  DOUBLE: "DOUBLE",

  @doc("INT type.")
  INT: "INT",

  @doc("LIST type.")
  LIST: "LIST",

  @doc("LONG type.")
  LONG: "LONG",

  @doc("PASSWORD type.")
  PASSWORD: "PASSWORD",

  @doc("SHORT type.")
  SHORT: "SHORT",

  @doc("STRING type.")
  STRING: "STRING",

  string,
}

@doc("Configuration key importance.")
union ConfigKeyInfoImportance {
  @doc("HIGH importance.")
  HIGH: "HIGH",

  @doc("LOW importance.")
  LOW: "LOW",

  @doc("MEDIUM importance.")
  MEDIUM: "MEDIUM",

  string,
}

@doc("Configuration key width.")
union ConfigKeyInfoWidth {
  @doc("LONG width.")
  LONG: "LONG",

  @doc("MEDIUM width.")
  MEDIUM: "MEDIUM",

  @doc("NONE width.")
  NONE: "NONE",

  @doc("SHORT width.")
  SHORT: "SHORT",

  string,
}

@doc("Properties of configuration key information.")
model ConfigKeyInformation {
  @doc("Configuration name.")
  name: string;

  @doc("Configuration type.")
  type: ConfigKeyInfoType;

  @doc("Whether this property is required.")
  required: boolean;

  @doc("Default value.")
  defaultValue?: string;

  @doc("Configuration importance.")
  importance?: ConfigKeyInfoImportance;

  @doc("Configuration documentation.")
  documentation?: string;

  @doc("Configuration group.")
  group?: string;

  @doc("Order in group.")
  orderInGroup?: int32;

  @doc("Configuration width.")
  width?: ConfigKeyInfoWidth;

  @doc("Configuration display name.")
  displayName?: string;

  @doc("Configuration dependents.")
  dependents?: string[];
}
