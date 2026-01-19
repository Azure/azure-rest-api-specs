import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

using Microsoft.ContainerService;

// Flatten properties for backward compatibility
<<<<<<< HEAD:specification/containerservice/DeploymentSafeguards.Management/back-compatible.tsp
=======
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
>>>>>>> upstream/main:specification/containerservice/resource-manager/Microsoft.ContainerService/deploymentsafeguards/back-compatible.tsp
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeploymentSafeguard.properties,
  "autorest"
);
