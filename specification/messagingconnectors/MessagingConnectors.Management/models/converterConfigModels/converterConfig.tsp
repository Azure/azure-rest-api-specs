import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.ConverterConfig;

@doc("Base class for Converter config")
@discriminator("type")
model ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType;
}

@doc("CsvConverter config")
model CsvConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.CsvConverter;
}

@doc("AvroConverter config")
model AvroConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.AvroConverter;
}

@doc("StringConverter config")
model StringConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.StringConverter;
}

@doc("ByteArrayConverter config")
model ByteArrayConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.ByteArrayConverter;
}

@doc("Json Decimal Format configuration")
union JsonDecimalFormat {
  @doc("Type of Base64.")
  Base64: "Base64",

  @doc("Type of Numeric.")
  Numeric: "Numeric",

  string,
}

@doc("JsonConverter config")
model JsonConverterConfig extends ConverterConfig {
  @doc("Type of converter.")
  type: ConverterType.JsonConverter;

  @doc("Whether schemas enabled.")
  schemasEnabled?: boolean;

  @doc("Format for Decimal type.")
  decimalFormat?: JsonDecimalFormat;
}

@doc("Enum of the type of Converter")
union ConverterType {
  @doc("This represents a converter for byte arrays format.")
  ByteArrayConverter: "ByteArrayConverter",

  @doc("This represents a converter for string format.")
  StringConverter: "StringConverter",

  @doc("This represents a converter for json format.")
  JsonConverter: "JsonConverter",

  @doc("This represents a converter for Avro format.")
  AvroConverter: "AvroConverter",

  @doc("This represents a converter for csv format.")
  CsvConverter: "CsvConverter",

  string,
}
