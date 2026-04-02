import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

@@clientName(Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationFluxConfigurationsMgmtClient",
  "python"
);

@@clientName(Microsoft.KubernetesConfiguration,
  "FluxConfigurationClient",
  "javascript"
);

@@clientName(Microsoft.KubernetesConfiguration, "FluxConfigClient", "java");
@@clientName(KustomizationDefinition.wait, "waitValue", "java");
@@clientName(KustomizationPatchDefinition.wait, "waitValue", "java");

@@clientName(OCIRepositoryDefinition, "OciRepositoryDefinition", "java");

@@clientName(OCIRepositoryRefDefinition, "OciRepositoryRefDefinition", "java");

@@clientName(SourceKindType.OCIRepository, "OciRepository", "java");

@@clientName(OCIRepositoryPatchDefinition,
  "OciRepositoryPatchDefinition",
  "java"
);

@@clientName(OCIRepositoryRefPatchDefinition,
  "OciRepositoryRefPatchDefinition",
  "java"
);
@@clientName(FluxConfigurations.fluxConfigOperationStatusGet,
  "OperationStatus",
  "java"
);
@@clientName(FluxConfigurations, "FluxConfigs", "java");
@@clientName(FluxConfigurationPatchProperties,
  "FluxConfigPatchProperties",
  "java"
);

// C# type customizations for backward compatibility
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
// C# fixes: rename interface to avoid namespace conflict (§4.9)
@@clientName(FluxConfigurations, "FluxConfigurationInterface", "csharp");
@@clientName(ProvisioningState, "FluxConfigurationProvisioningState", "csharp");
@@clientName(ScopeType, "FluxConfigurationScopeType", "csharp");
@@clientName(SourceKindType, "FluxConfigurationSourceKindType", "csharp");
@@clientName(ProviderType, "FluxConfigurationProviderType", "csharp");
@@clientName(OperationType, "FluxConfigurationOperationType", "csharp");
@@clientName(FluxConfigurationProperties.suspend, "IsSuspended", "csharp");
@@clientName(FluxConfigurationProperties.waitForReconciliation,
  "IsWaitForReconciliation",
  "csharp"
);
@@clientName(BucketDefinition.insecure, "IsInsecure", "csharp");
@@clientName(KustomizationDefinition.force, "IsForce", "csharp");
@@clientName(KustomizationDefinition.prune, "IsPrune", "csharp");
@@clientName(KustomizationDefinition.wait, "IsWait", "csharp");
@@clientName(SubstituteFromDefinition.optional, "IsOptional", "csharp");
@@clientName(ServicePrincipalDefinition.clientCertificateSendChain,
  "IsClientCertificateSendChain",
  "csharp"
);
@@clientName(FluxConfigurationPatchProperties.suspend, "IsSuspended", "csharp");
@@clientName(BucketPatchDefinition.insecure, "IsInsecure", "csharp");
@@clientName(KustomizationPatchDefinition.force, "IsForce", "csharp");
@@clientName(KustomizationPatchDefinition.prune, "IsPrune", "csharp");
@@clientName(KustomizationPatchDefinition.wait, "IsWait", "csharp");
@@clientName(SubstituteFromPatchDefinition.optional, "IsOptional", "csharp");
@@clientName(ServicePrincipalPatchDefinition.clientCertificateSendChain,
  "IsClientCertificateSendChain",
  "csharp"
);
@@clientName(OCIRepositoryDefinition, "OciRepositoryDefinition", "csharp");
@@clientName(OCIRepositoryRefDefinition,
  "OciRepositoryRefDefinition",
  "csharp"
);
@@clientName(OCIRepositoryPatchDefinition,
  "OciRepositoryPatchDefinition",
  "csharp"
);
@@clientName(OCIRepositoryRefPatchDefinition,
  "OciRepositoryRefPatchDefinition",
  "csharp"
);
@@clientName(SourceKindType.OCIRepository, "OciRepository", "csharp");

// Exclude OperationStatus APIs from C# SDK - they are built into the core library
@@scope(FluxConfigurations.fluxConfigOperationStatusGet, "!csharp");
