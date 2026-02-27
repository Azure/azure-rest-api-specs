import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Connector.SourceConnector.SourceDataFormat;

@doc("Source data format Types")
union SourceDataFormatType {
  @doc("Json format")
  Json: "Json",

  @doc("Csv format")
  Csv: "Csv",

  @doc("ConfluentAvro format")
  ConfluentAvro: "ConfluentAvro",

  @doc("Avro format")
  Avro: "Avro",

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

@doc("CSV Source data format model")
model CsvSourceDataFormat extends SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatType.Csv;

  @doc("Whether the CSV data has a header row.")
  dataWithHeader?: boolean;

  @doc("Default is UTF-8. Supported Encodings: https://docs.oracle.com/javase/8/docs/technotes/guides/intl/encoding.doc.html")
  textCharset?: string;

  @doc("The character used to separate columns in the CSV data.")
  @minLength(1)
  @maxLength(1)
  columnSeparator?: string;
}

@doc("ConfluentAvro Source data format model")
model ConfluentAvroSourceDataFormat extends SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatType.ConfluentAvro;

  @doc("Registry url for Confluent.")
  schemaRegistryUrl: url;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "not a secret"
  @doc("Access key for Confluent.")
  key?: string;

  @doc("Secret for Confluent.")
  @secret
  secret?: string;

  @doc("subject name.")
  subjectName?: string;

  @doc("schema context.")
  schemaContext?: string;

  @doc("Configuration for ssl.")
  sslConfiguration?: Models.Auth.SslConfiguration;

  @doc("Client certificate for Confluent.")
  clientCertAuthentication?: Models.Auth.CertificateAuthentication;
}

@doc("Avro Source data format model")
model AvroSourceDataFormat extends SourceDataFormat {
  @doc("Type of data format")
  type: SourceDataFormatType.Avro;
}
