import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../connectorModels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Type of DataRange")
union DataRangeType {
  @doc("Max limit range type")
  Limit: "Limit",

  string,
}

@doc("Base config for DataRange")
@discriminator("type")
model DataRangeBaseConfig {
  @doc("type of dataRange")
  type: DataRangeType;
}

@doc("DataRange by max records limit")
model DataRangeLimit extends DataRangeBaseConfig {
  @doc("Limit type of DataRange")
  type: DataRangeType.Limit;

  @doc("Max Limit for DataRange")
  limit: int32;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Properties of one DataPreview")
model DataPreviewProperties {
  @doc("Properties for the source")
  dataSourceProperties: DataSourceProperties;

  @doc("DataRange for DataPreview")
  dataRange: DataRangeBaseConfig;

  @doc("Type of the Connector.")
  converterConfig: ConverterConfig;

  @doc("Data format of the data source")
  sourceDataFormat?: SourceDataFormat;

  @doc("Cloud events config")
  cloudEventsConfig?: CloudEventsConfig;
}

@doc("Properties of DataPreview results")
model DataPreviewResults {
  @doc("Count of DataPreview results")
  count: int32;

  @doc("Content of DataPreview results")
  results: string[];
}
