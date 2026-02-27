import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../fileReference.tsp";

namespace Microsoft.MessagingConnectors.Models.DataPreview;

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

@doc("Configuration of datapreview limit")
model FetchingLimits {
  @doc("Max starting time in Millisecond for datapreview.")
  maxStartingTimeMs: int64;

  @doc("Max idle time in Millisecond for datapreview.")
  maxIdleTimeMs: int64;

  @doc("Max polling time in Millisecond for datapreview.")
  maxPollingTimeMs: int64;

  @doc("Max record count for datapreview.")
  maxRecordCount: int32;

  @doc("Max data size in Millisecond for datapreview.")
  maxDataSize: int64;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Request of DataPreview")
model DataPreviewRequest {
  @doc("DataPreview properties")
  dataPreviewProperties: DataPreviewProperties;

  @doc("Skip validation or not")
  skipValidation?: boolean;

  @doc("Configuration of datapreview limit.")
  fetchingLimits?: FetchingLimits;
}

@doc("Properties of one DataPreview")
model DataPreviewProperties {
  @doc("Properties for the source")
  dataSourceProperties: Models.DataSource.DataSourceProperties;

  @doc("DataRange for DataPreview")
  dataRange: DataRangeBaseConfig;

  @doc("Data format of the data source")
  sourceDataFormat?: Models.Connector.SourceConnector.SourceDataFormat.SourceDataFormat;

  @doc("Cloud events config")
  cloudEventsConfig?: Models.Connector.SourceConnector.CloudEventsConfig.CloudEventsConfig;

  @doc("networkProperties config.")
  networkProperties?: Models.Network.NetworkProperties;
}

@doc("Header item")
model DataHeader {
  @doc("Header key")
  key: string;

  @doc("Header value")
  value: string;
}

@doc("Preview result")
model JsonConvertedRecord {
  @Azure.ResourceManager.identifiers(#[])
  @doc("Header of DataPreview result")
  headers: DataHeader[];

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "not a secret"
  @doc("Key of DataPreview result")
  key: string;

  @doc("ValueSchema of DataPreview result")
  valueSchema: string;

  @doc("Value of DataPreview result")
  value: string;
}

@doc("Result Code of DataPreview request")
union DataPreviewResultCode {
  @doc("Represents DataPreview Timeout.")
  Timeout: "Timeout",

  @doc("Represents No Data of DataPreview.")
  NoData: "NoData",

  @doc("Represents Succeeded of DataPreview.")
  Succeeded: "Succeeded",

  @doc("Represents DataPreview Succeeded with skipped data due to up limit.")
  SucceededWithSkippedDataUpLimit: "SucceededWithSkippedDataUpLimit",

  @doc("Represents DataPreview Succeeded with skipped data due to down limit")
  SucceededWithSkippedDataDownLimit: "SucceededWithSkippedDataDownLimit",

  @doc("Represents DataPreview No data with skipped data due to up limit")
  NoDataWithSkippedDataUpLimit: "NoDataWithSkippedDataUpLimit",

  string,
}

@doc("Properties of DataPreview results")
model DataPreviewResults {
  @Azure.ResourceManager.identifiers(#[])
  @doc("Content of DataPreview results in Json format.")
  results: JsonConvertedRecord[];

  @doc("Skipped records count of DataPreview.")
  skippedCount: int32;

  @doc("Result records count of DataPreview.")
  resultCount: int32;

  @doc("Result message of DataPreview.")
  message: string;

  @doc("Result code of DataPreview.")
  resultCode: DataPreviewResultCode;
}
