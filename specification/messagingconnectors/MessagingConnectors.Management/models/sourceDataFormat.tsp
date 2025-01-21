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

@doc("Source data format Types")
union SourceDataFormatType {
  @doc("Json format")
  Json: "Json",

  @doc("Csv format")
  Csv: "Csv",

  @doc("ConfluentAvro format")
  ConfluentAvro: "ConfluentAvro",

  string,
}

@doc("Source data format base model")
@discriminator("type")
model SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatType;
}

@doc("JSON source data format model")
model JsonSourceDataFormat extends SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatType.Json;

  @doc("Charset supported by Java language")
  textCharset: string;
}

@doc("Delimiter for csv")
union CsvDelimiter {
  @doc("Pipe delimiter")
  Pipe: "Pipe",

  @doc("Comma delimiter")
  Comma: "Comma",

  @doc("SemiColon delimiter")
  SemiColon: "SemiColon",

  @doc("Space delimiter")
  Space: "Space",

  @doc("Tab delimiter")
  Tab: "Tab",

  string,
}

@doc("CsvHeader types")
union CsvHeaderType {
  @doc("include CSV header")
  IncludeHeader: "IncludeHeader",

  @doc("exclude CSV header")
  ExcludeHeader: "ExcludeHeader",

  string,
}

@doc("CSV Source data format model")
model CsvSourceDataFormat extends SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatType.Csv;

  @doc("CSV header type")
  header: CsvHeaderType;

  @doc("CSV Delimiter")
  delimiter: CsvDelimiter;

  @doc("Charset supported by Java language")
  textCharset: string;
}

@doc("ConfluentAvro Source data format model")
model ConfluentAvroSourceDataFormat extends SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatType.ConfluentAvro;

  @doc("Registry url for Confluent.")
  schemaRegistryUrl: url;

  @doc("Access key for Confluent.")
  key: string;

  @doc("Secret for Confluent.")
  @secret
  secret: string;

  @doc("Source Topic name.")
  sourceTopic: string;
}
