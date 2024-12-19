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

@doc("Configuration for BitCoinSourceConnector")
model BitCoinSourceConnectorProperties extends ConnectorProperties {
  @doc("Type of BitCoinSourceConnector")
  connectorType: ConnectorType.BitCoinSource;

  @doc("Direction of the Source Connector.")
  connectorDirection?: Direction = Direction.Source;
}
