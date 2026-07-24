import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Microsoft.ContainerService;

@@clientName(
  Microsoft.ContainerService,
  "ContainerServiceSafeguardsMgmtClient",
  "python"
);

// JavaScript SDK visibility workaround:
// The canonical create model includes server-side read-only required fields
// (for example systemExcludedNamespaces), so provide a write-specific model
// for JavaScript create input.
namespace Microsoft.ContainerService {
  @doc("DeploymentSafeguards properties for create/update operations, omitting server-side read-only fields such as systemExcludedNamespaces and provisioningState.")
  model DeploymentSafeguardsPropertiesCreate {
    @doc("The deployment safeguards level. Possible values are Warn and Enforce")
    level: DeploymentSafeguardsLevel;

    @doc("User defined list of namespaces to exclude from Deployment Safeguards. Deployments in these namespaces will not be checked against any safeguards")
    excludedNamespaces?: Array<string>;

    @doc("The pod security standards level")
    @added(Versions.v2025_05_02_preview)
    podSecurityStandardsLevel?: PodSecurityStandardsLevel;
  }

  @doc("Deployment safeguard create/update request body.")
  model DeploymentSafeguardCreate {
    @doc("The resource-specific properties for this resource.")
    properties: DeploymentSafeguardsPropertiesCreate;
  }
}

@@alternateType(
  Microsoft.ContainerService.DeploymentSafeguards.create::parameters.resource,
  Microsoft.ContainerService.DeploymentSafeguardCreate,
  "javascript"
);

@@alternateType(DeploymentSafeguard.eTag, Azure.Core.eTag, "csharp");
