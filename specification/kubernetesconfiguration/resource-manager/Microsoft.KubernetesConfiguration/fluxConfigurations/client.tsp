import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

@@clientName(
  Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationFluxConfigurationsMgmtClient",
  "python"
);

@@clientName(
  Microsoft.KubernetesConfiguration,
  "FluxConfigurationClient",
  "javascript"
);

@@clientName(Microsoft.KubernetesConfiguration, "FluxConfigClient", "java");
@@clientName(
  Microsoft.KubernetesConfiguration.KustomizationDefinition.wait,
  "waitValue",
  "java"
);
@@clientName(
  Microsoft.KubernetesConfiguration.KustomizationPatchDefinition.wait,
  "waitValue",
  "java"
);

@@clientName(
  Microsoft.KubernetesConfiguration.OCIRepositoryDefinition,
  "OciRepositoryDefinition",
  "java"
);

@@clientName(
  Microsoft.KubernetesConfiguration.OCIRepositoryRefDefinition,
  "OciRepositoryRefDefinition",
  "java"
);

@@clientName(
  Microsoft.KubernetesConfiguration.SourceKindType.OCIRepository,
  "OciRepository",
  "java"
);

@@clientName(
  Microsoft.KubernetesConfiguration.OCIRepositoryPatchDefinition,
  "OciRepositoryPatchDefinition",
  "java"
);

@@clientName(
  Microsoft.KubernetesConfiguration.OCIRepositoryRefPatchDefinition,
  "OciRepositoryRefPatchDefinition",
  "java"
);
@@clientName(
  Microsoft.KubernetesConfiguration.FluxConfigurations.fluxConfigOperationStatusGet,
  "OperationStatus",
  "java"
);
@@clientName(
  Microsoft.KubernetesConfiguration.FluxConfigurations,
  "FluxConfigs",
  "java"
);
@@clientName(
  Microsoft.KubernetesConfiguration.FluxConfigurationPatchProperties,
  "FluxConfigPatchProperties",
  "java"
);

// C# type customizations for backward compatibility
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
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
@@clientName(
  FluxConfigurationProperties.waitForReconciliation,
  "IsWaitForReconciliation",
  "csharp"
);
@@clientName(BucketDefinition.insecure, "IsInsecure", "csharp");
@@clientName(KustomizationDefinition.force, "IsForce", "csharp");
@@clientName(KustomizationDefinition.prune, "IsPrune", "csharp");
@@clientName(KustomizationDefinition.wait, "IsWait", "csharp");
@@clientName(SubstituteFromDefinition.optional, "IsOptional", "csharp");
@@clientName(
  ServicePrincipalDefinition.clientCertificateSendChain,
  "IsClientCertificateSendChain",
  "csharp"
);
@@clientName(FluxConfigurationPatchProperties.suspend, "IsSuspended", "csharp");
@@clientName(BucketPatchDefinition.insecure, "IsInsecure", "csharp");
@@clientName(OCIRepositoryDefinition.insecure, "IsInsecure", "csharp");
@@clientName(OCIRepositoryPatchDefinition.insecure, "IsInsecure", "csharp");
@@clientName(KustomizationPatchDefinition.force, "IsForce", "csharp");
@@clientName(KustomizationPatchDefinition.prune, "IsPrune", "csharp");
@@clientName(KustomizationPatchDefinition.wait, "IsWait", "csharp");
@@clientName(SubstituteFromPatchDefinition.optional, "IsOptional", "csharp");
@@clientName(
  ServicePrincipalPatchDefinition.clientCertificateSendChain,
  "IsClientCertificateSendChain",
  "csharp"
);
// C# fixes (AZC0031): drop redundant "Definition" suffix from model type names
@@clientName(AzureBlobDefinition, "AzureBlob", "csharp");
@@clientName(AzureBlobPatchDefinition, "AzureBlobPatch", "csharp");
@@clientName(BucketDefinition, "FluxBucket", "csharp");
@@clientName(BucketPatchDefinition, "FluxBucketPatch", "csharp");
@@clientName(GitRepositoryDefinition, "FluxGitRepository", "csharp");
@@clientName(GitRepositoryPatchDefinition, "FluxGitRepositoryPatch", "csharp");
@@clientName(KustomizationDefinition, "Kustomization", "csharp");
@@clientName(KustomizationPatchDefinition, "KustomizationPatch", "csharp");
@@clientName(LayerSelectorDefinition, "FluxLayerSelector", "csharp");
@@clientName(LayerSelectorPatchDefinition, "FluxLayerSelectorPatch", "csharp");
@@clientName(MatchOidcIdentityDefinition, "MatchOidcIdentity", "csharp");
@@clientName(
  MatchOidcIdentityPatchDefinition,
  "MatchOidcIdentityPatch",
  "csharp"
);
@@clientName(OCIRepositoryDefinition, "OciRepository", "csharp");
@@clientName(OCIRepositoryPatchDefinition, "OciRepositoryPatch", "csharp");
@@clientName(OCIRepositoryRefDefinition, "OciRepositoryRef", "csharp");
@@clientName(
  OCIRepositoryRefPatchDefinition,
  "OciRepositoryRefPatch",
  "csharp"
);
@@clientName(PostBuildDefinition, "FluxPostBuild", "csharp");
@@clientName(PostBuildPatchDefinition, "FluxPostBuildPatch", "csharp");
@@clientName(ServicePrincipalDefinition, "FluxServicePrincipal", "csharp");
@@clientName(
  ServicePrincipalPatchDefinition,
  "FluxServicePrincipalPatch",
  "csharp"
);
@@clientName(SubstituteFromDefinition, "FluxSubstitution", "csharp");
@@clientName(SubstituteFromPatchDefinition, "FluxSubstitutionPatch", "csharp");
@@clientName(TlsConfigDefinition, "FluxTlsConfig", "csharp");
@@clientName(TlsConfigPatchDefinition, "FluxTlsConfigPatch", "csharp");
@@clientName(VerifyDefinition, "OciRepositoryVerify", "csharp");
@@clientName(VerifyPatchDefinition, "OciRepositoryVerifyPatch", "csharp");
@@clientName(
  HelmReleasePropertiesDefinition,
  "HelmReleaseProperties",
  "csharp"
);
@@clientName(ObjectReferenceDefinition, "FluxObjectReference", "csharp");
@@clientName(
  ObjectStatusConditionDefinition,
  "FluxObjectStatusCondition",
  "csharp"
);
@@clientName(ObjectStatusDefinition, "FluxObjectStatus", "csharp");
@@clientName(RepositoryRefDefinition, "FluxRepositoryReference", "csharp");
@@clientName(SourceKindType.OCIRepository, "OciRepository", "csharp");

// Exclude OperationStatus APIs from C# SDK - they are built into the core library
@@scope(FluxConfigurations.fluxConfigOperationStatusGet, "!csharp");
