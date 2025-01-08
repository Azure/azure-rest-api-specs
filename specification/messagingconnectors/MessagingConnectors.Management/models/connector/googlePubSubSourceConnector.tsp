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

@doc("Configuration for GooglePubSubSourceConnector")
model GooglePubSubSourceConnectorProperties extends DataSourceProperties {
  @doc("Type of GooglePubSubSourceConnector")
  connectorType: ConnectorType.GooglePubSubSource;

  @doc("Google Cloud project ID where the Pub/Sub instance resides, assigned by GCP.")
  projectId: string;

  @doc("Google Cloud subscription name where the Pub/Sub instance resides.")
  subscriptionName: string;

  @doc("Google Cloud account key, assigned by GCP.")
  @secret
  accountKey: string;
}
