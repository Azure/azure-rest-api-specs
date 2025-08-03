import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource.Kinesis;

@doc("StartPosition types for Kinesis, https://docs.aws.amazon.com/kinesis/latest/APIReference/API_StartingPosition.html")
union KinesisStartPositionType {
  @doc("TrimHorizon type")
  TrimHorizon: "TrimHorizon",

  @doc("Latest type")
  Latest: "Latest",

  @doc("AtSequenceNumber type")
  AtSequenceNumber: "AtSequenceNumber",

  @doc("AfterSequenceNumber type")
  AfterSequenceNumber: "AfterSequenceNumber",

  @doc("AtTimestamp type")
  AtTimestamp: "AtTimestamp",

  string,
}

@doc("Configuration for KinesisSourceConnector")
model KinesisSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of KinesisSourceConnector")
  connectorType: Models.Connector.ConnectorType.KinesisSource;

  @doc("AccessKeyId for AWS Kinesis Server.")
  awsAccessKeyId: string;

  @doc("SecretAccessKey for AWS Kinesis Server.")
  @secret
  awsSecretAccessKey: string;

  @doc("Region of AWS Kinesis Server.")
  awsKinesisRegion: string;

  @doc("StreamName in AWS Kinesis Server.")
  awsKinesisStreamName: string;

  @doc("startPosition supported by Kinesis.")
  startPosition: KinesisStartPositionType;

  @doc("startSequence for startPosition.")
  startSequence?: string;

  @doc("startTime for startPosition.")
  startTime?: utcDateTime;
}
