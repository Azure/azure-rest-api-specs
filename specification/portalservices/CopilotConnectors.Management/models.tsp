import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.PortalServices;

@armResourceOperations
interface Operations extends Azure.ResourceManager.Operations {}

@doc("Type of Copilot Connector.")
union CopilotConnectorType {
  string,

  @doc("MCP server connector")
  MCP: "MCP",
}

@doc("The Copilot Connector resource")
model CopilotConnectorProperties {
  @doc("Type of Copilot Connector.")
  connectorType: CopilotConnectorType;

  @doc("String describing this Copilot Connector")
  description: string;

  @doc("Boolean indicating if Copilot Connector is enabled")
  enabled: boolean;

  @doc("Used to store connection information for CopilotConnector")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  connectionInfo?: ConnectionInfo;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Used to store connection information for MCP Server")
model ConnectionInfo {
  @doc("The connector server endpoint")
  endpoint: string;

  @doc("Used to store authentication settings for MCP server endpoint")
  authenticationSettings: AuthenticationSettings;
}

@doc("Authentication settings")
model AuthenticationSettings {
  @doc("Used to store api key authentication settings for CopilotConnector endpoint")
  apiKey: ApiKeyAuthenticationSettings;
}

@doc("Authentication settings")
model ApiKeyAuthenticationSettings {
  @doc("Used to store api key for CopilotConnector endpoint")
  value: string;
}

@doc("The Copilot Connector Patch resource")
model PatchableCopilotConnectorProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("Resource tags")
  tags?: Record<string>;
}
