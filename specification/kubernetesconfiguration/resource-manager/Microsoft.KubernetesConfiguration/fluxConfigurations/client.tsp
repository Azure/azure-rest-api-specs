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
@@clientName(ProviderType, "FluxGitRepositoryProviderType", "csharp");
@@clientName(OperationType, "FluxLayerOperationType", "csharp");
@@clientName(FluxConfigurationProperties.suspend, "IsSuspended", "csharp");
@@clientName(FluxConfigurationProperties.waitForReconciliation,
  "IsWaitForReconciliation",
  "csharp"
);
@@clientName(BucketDefinition.insecure, "IsInsecure", "csharp");
@@clientName(GitRepositoryDefinition.httpsCACert,
  "HttpsCaCertificate",
  "csharp"
);
@@clientName(KustomizationDefinition.force, "IsForceEnabled", "csharp");
@@clientName(KustomizationDefinition.prune, "IsPruningEnabled", "csharp");
@@clientName(KustomizationDefinition.wait, "IsHealthCheckEnabled", "csharp");
@@clientName(SubstituteFromDefinition.optional, "IsOptional", "csharp");
@@clientName(ServicePrincipalDefinition.clientCertificateSendChain,
  "IsClientCertificateChainIncluded",
  "csharp"
);
@@clientName(FluxConfigurationPatchProperties.suspend, "IsSuspended", "csharp");
@@clientName(BucketPatchDefinition.insecure, "IsInsecure", "csharp");
@@clientName(OCIRepositoryDefinition.insecure, "IsInsecure", "csharp");
@@clientName(OCIRepositoryPatchDefinition.insecure, "IsInsecure", "csharp");
@@clientName(GitRepositoryPatchDefinition.httpsCACert,
  "HttpsCaCertificate",
  "csharp"
);
@@clientName(KustomizationPatchDefinition.force, "IsForceEnabled", "csharp");
@@clientName(KustomizationPatchDefinition.prune, "IsPruningEnabled", "csharp");
@@clientName(KustomizationPatchDefinition.wait,
  "IsHealthCheckEnabled",
  "csharp"
);
@@clientName(SubstituteFromPatchDefinition.optional, "IsOptional", "csharp");
@@clientName(ServicePrincipalPatchDefinition.clientCertificateSendChain,
  "IsClientCertificateChainIncluded",
  "csharp"
);
// C# fixes (AZC0031): drop redundant "Definition" suffix from model type names
@@clientName(AzureBlobDefinition, "FluxAzureBlob", "csharp");
@@clientName(AzureBlobPatchDefinition, "FluxAzureBlobPatch", "csharp");
@@clientName(BucketDefinition, "FluxBucket", "csharp");
@@clientName(BucketPatchDefinition, "FluxBucketPatch", "csharp");
@@clientName(GitRepositoryDefinition, "FluxGitRepository", "csharp");
@@clientName(GitRepositoryPatchDefinition, "FluxGitRepositoryPatch", "csharp");
@@clientName(KustomizationDefinition, "FluxKustomization", "csharp");
@@clientName(KustomizationPatchDefinition, "FluxKustomizationPatch", "csharp");
@@clientName(LayerSelectorDefinition, "FluxLayerSelector", "csharp");
@@clientName(LayerSelectorPatchDefinition, "FluxLayerSelectorPatch", "csharp");
@@clientName(MatchOidcIdentityDefinition,
  "FluxOciRepositoryMatchOidcIdentity",
  "csharp"
);
@@clientName(MatchOidcIdentityPatchDefinition,
  "FluxOciRepositoryMatchOidcIdentityPatch",
  "csharp"
);
@@clientName(OCIRepositoryDefinition, "FluxOciRepository", "csharp");
@@clientName(OCIRepositoryPatchDefinition, "FluxOciRepositoryPatch", "csharp");
@@clientName(OCIRepositoryRefDefinition,
  "FluxOciRepositoryReference",
  "csharp"
);
@@clientName(OCIRepositoryRefPatchDefinition,
  "FluxOciRepositoryReferencePatch",
  "csharp"
);
@@clientName(PostBuildDefinition, "FluxPostBuild", "csharp");
@@clientName(PostBuildPatchDefinition, "FluxPostBuildPatch", "csharp");
@@clientName(ServicePrincipalDefinition, "FluxServicePrincipal", "csharp");
@@clientName(ServicePrincipalPatchDefinition,
  "FluxServicePrincipalPatch",
  "csharp"
);
@@clientName(SubstituteFromDefinition, "FluxSubstitution", "csharp");
@@clientName(SubstituteFromPatchDefinition, "FluxSubstitutionPatch", "csharp");
@@clientName(TlsConfigDefinition, "FluxTlsConfig", "csharp");
@@clientName(TlsConfigPatchDefinition, "FluxTlsConfigPatch", "csharp");
@@clientName(VerifyDefinition, "FluxOciRepositoryVerification", "csharp");
@@clientName(VerifyPatchDefinition,
  "FluxOciRepositoryVerificationPatch",
  "csharp"
);
@@clientName(HelmReleasePropertiesDefinition,
  "FluxHelmReleaseProperties",
  "csharp"
);
@@clientName(ObjectReferenceDefinition, "FluxObjectReference", "csharp");
@@clientName(ObjectStatusConditionDefinition,
  "FluxObjectStatusCondition",
  "csharp"
);
@@clientName(ObjectStatusDefinition, "FluxObjectStatus", "csharp");
@@clientName(RepositoryRefDefinition, "FluxRepositoryReference", "csharp");
@@clientName(SourceKindType.OCIRepository, "OciRepository", "csharp");

// Exclude OperationStatus APIs from C# SDK - they are built into the core library
@@scope(FluxConfigurations.fluxConfigOperationStatusGet, "!csharp");
