import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// C# type customizations for backward compatibility
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@clientName(Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationFluxConfigurationsMgmtClient",
  "python"
);

@@clientName(Microsoft.KubernetesConfiguration,
  "FluxConfigurationClient",
  "javascript"
);

@@clientName(Microsoft.KubernetesConfiguration, "FluxConfigClient", "java");
@@clientName(Microsoft.KubernetesConfiguration.KustomizationDefinition.wait,
  "waitValue",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.KustomizationPatchDefinition.wait,
  "waitValue",
  "java"
);

@@clientName(Microsoft.KubernetesConfiguration.OCIRepositoryDefinition,
  "OciRepositoryDefinition",
  "java"
);

@@clientName(Microsoft.KubernetesConfiguration.OCIRepositoryRefDefinition,
  "OciRepositoryRefDefinition",
  "java"
);

@@clientName(Microsoft.KubernetesConfiguration.SourceKindType.OCIRepository,
  "OciRepository",
  "java"
);

@@clientName(Microsoft.KubernetesConfiguration.OCIRepositoryPatchDefinition,
  "OciRepositoryPatchDefinition",
  "java"
);

@@clientName(Microsoft.KubernetesConfiguration.OCIRepositoryRefPatchDefinition,
  "OciRepositoryRefPatchDefinition",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.FluxConfigurations.fluxConfigOperationStatusGet,
  "OperationStatus",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.FluxConfigurations,
  "FluxConfigs",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.FluxConfigurationPatchProperties,
  "FluxConfigPatchProperties",
  "java"
);

// Exclude OperationStatus APIs from C# SDK - they are built into the core library
@@scope(Microsoft.KubernetesConfiguration.FluxConfigurations.fluxConfigOperationStatusGet,
  "!csharp"
);
