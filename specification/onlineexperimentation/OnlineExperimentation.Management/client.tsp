import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.OnlineExperimentation;

@@clientName(Microsoft.OnlineExperimentation,
  "OnlineExperimentationMgmtClient",
  "java"
);

@@clientName(Microsoft.OnlineExperimentation,
  "OnlineExperimentationMgmtClient",
  "python"
);

// CSharp
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "OnlineExperimentationProvisioningState",
  "csharp"
);
@@alternateType(OnlineExperimentationWorkspaceProperties.workspaceId,
  uuid,
  "csharp"
);

@@clientName(PrivateEndpointConnection,
  "OnlineExperimentationPrivateEndpointConnection",
  "csharp"
);

@@clientName(PrivateLinkResource, "OnlineExperimentationPrivateLink", "csharp");

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model SubResource {
    /** the id */
    id?: armResourceIdentifier;
  }
}

@@alternateType(Azure.ResourceManager.PrivateEndpointConnectionProperties.privateEndpoint,
  Azure.ResourceManager.Models.SubResource,
  "csharp"
);
