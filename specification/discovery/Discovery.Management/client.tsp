import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Rename DiscoveryStorage to ManagedStorage for Go SDK to avoid collision with Storage type
// after the Go emitter removes the "Discovery" prefix
@@clientName(Microsoft.Discovery.DiscoveryStorage,
  "DiscoveryManagedStorage",
  "go"
);

@@clientName(Microsoft.Discovery, "DiscoveryMgmtClient", "python");

@doc("Tool tracked resource")
model ToolUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?:ToolPropertiesUpdate;
}

@doc("Discovery Tool list item properties")
model ToolPropertiesUpdate {
  ...DiscoveryResourceProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Environment variables to make available")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  environmentVariables?: Record<string>;

  ...WithDefinitionContent;
}

@@alternateType(Tools.update::parameters.body,
  ToolUpdate,
  "javascript"
);