import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerService;
using Azure.Core;
using TypeSpec.Http;

// Client name customizations
@@clientName(Microsoft.ContainerService,
  "ContainerServiceAIManagerClient",
  "java"
);

@@clientName(Microsoft.ContainerService,
  "ContainerServiceAIManagerClient",
  "python"
);

@@clientName(Microsoft.ContainerService,
  "ContainerServiceAIManagerClient",
  "csharp"
);

@@clientName(Microsoft.ContainerService,
  "ContainerServiceAIManagerClient",
  "go"
);

// Property name customizations
@@clientName(Azure.ResourceManager.EntityTagProperty.eTag, "etag", "java");

// Legacy type handling
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@@clientName(Azure.ResourceManager.Legacy.ManagedServiceIdentityV4,
  "ManagedServiceIdentity"
);
