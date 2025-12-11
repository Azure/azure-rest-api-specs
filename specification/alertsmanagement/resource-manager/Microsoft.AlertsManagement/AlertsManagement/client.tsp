import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertsClientOptions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scope: string;
}

@@Azure.ClientGenerator.Core.clientInitialization(Microsoft.AlertsManagement,
  {
    parameters: AlertsClientOptions,
  }
);
