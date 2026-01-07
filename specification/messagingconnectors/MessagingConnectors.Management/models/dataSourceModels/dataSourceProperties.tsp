import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.DataSource;

@doc("Base properties for source.")
@discriminator("connectorType")
model DataSourceProperties {
  @doc("Type of the Connector.")
  connectorType: Models.Connector.ConnectorType;

  @doc("Subtype of the Connector.")
  connectorSubType?: Models.Connector.ConnectorSubType;
}
