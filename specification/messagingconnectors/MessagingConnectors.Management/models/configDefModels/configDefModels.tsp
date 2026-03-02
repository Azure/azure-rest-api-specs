import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../fileReference.tsp";

namespace Microsoft.MessagingConnectors.Models.ConfigDef;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Request of ConfigDef")
model ConfigurationDefRequest {
  @doc("Id used for isolation.")
  isolationId: string;

  @doc("Package storage information for jar package.")
  packageStorageInformation: Models.DataSource.CustomConnector.PackageStorageInformation;
}

@doc("Type of ConfigDef")
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

@doc("ConfigDef Importance.")
union ConfigKeyInfoImportance {
  @doc("HIGH type.")
  HIGH: "HIGH",

  @doc("LOW type.")
  LOW: "LOW",

  @doc("MEDIUM type.")
  MEDIUM: "MEDIUM",

  string,
}

@doc("ConfigDef Importance.")
union ConfigKeyInfoWidth {
  @doc("LONG type.")
  LONG: "LONG",

  @doc("MEDIUM type.")
  MEDIUM: "MEDIUM",

  @doc("NONE type.")
  NONE: "NONE",

  @doc("SHORT type.")
  SHORT: "SHORT",

  string,
}

@doc("Properties of ConfigKey Information")
model ConfigKeyInformation {
  @doc("Configuration name.")
  name: string;

  @doc("Configuration type.")
  type: ConfigKeyInfoType;

  @doc("Whether this property is required.")
  required: boolean;

  @doc("default value.")
  defaultValue?: string;

  @doc("Configuration Importance.")
  importance?: ConfigKeyInfoImportance;

  @doc("Configuration documentation.")
  documentation?: string;

  @doc("Configuration group.")
  group?: string;

  @doc("Configuration group.")
  orderInGroup?: int32;

  @doc("Configuration Width.")
  width?: ConfigKeyInfoWidth;

  @doc("Configuration displayName.")
  displayName?: string;

  @doc("Configuration dependents.")
  dependents?: string[];
}

@doc("Properties of ConfigDef results")
model ConfigurationDefResult {
  @Azure.ResourceManager.identifiers(#[])
  @doc("Array of configDef;")
  configurationDefs: ConfigurationDef[];
}

@doc("Property of ConfigDef.")
model ConfigurationDef {
  @doc("class name in package.")
  className: string;

  @Azure.ResourceManager.identifiers(#[])
  @doc("Array of configKey information.")
  configKeysInformations: ConfigKeyInformation[];
}
