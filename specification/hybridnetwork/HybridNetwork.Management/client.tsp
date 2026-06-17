import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.HybridNetwork;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

@@clientName(HelmInstallOptions.wait, "waitOption", "java");
@@clientName(HelmUpgradeOptions.wait, "waitOption", "java");

@@usage(Component, Usage.input | Usage.output);
@@clientName(ExecuteRequestParameters, "ExecuteRequestContent", "csharp");
@@clientName(ProxyArtifact.list, "GetProxyArtifacts", "csharp");
@@clientName(ProxyArtifact.proxyArtifactGet,
  "GetProxyArtifactVersions",
  "csharp"
);
@@clientName(ProxyArtifact.updateState, "UpdateStateProxyArtifact", "csharp");
@@clientName(Status, "ComponentStatus", "csharp");
@@clientName(Resources, "ComponentKubernetesResources", "csharp");
@@clientName(Deployment, "KubernetesDeployment", "csharp");
@@clientName(Pod, "KubernetesPod", "csharp");
@@clientName(ReplicaSet, "KubernetesReplicaSet", "csharp");
@@clientName(StatefulSet, "KubernetesStatefulSet", "csharp");
@@clientName(DaemonSet, "KubernetesDaemonSet", "csharp");
@@clientName(HelmInstallOptions, "HelmInstallConfig", "csharp");
@@clientName(HelmUpgradeOptions, "HelmUpgradeConfig", "csharp");
@@clientName(HelmMappingRuleProfileOptions,
  "HelmMappingRuleProfileConfig",
  "csharp"
);
@@clientName(AzureCoreNFVIDetails, "AzureCoreNfviDetails", "csharp");
@@clientName(AzureOperatorNexusClusterNFVIDetails,
  "AzureOperatorNexusClusterNfviDetails",
  "csharp"
);
@@clientName(VirtualNetworkFunctionNFVIType,
  "VirtualNetworkFunctionNfviType",
  "csharp"
);
@@clientName(ContainerizedNetworkFunctionNFVIType,
  "ContainerizedNetworkFunctionNfviType",
  "csharp"
);
@@clientName(VirtualNetworkFunctionNetworkFunctionDefinitionVersion,
  "VirtualNetworkFunctionDefinitionVersion",
  "csharp"
);
@@clientName(NfviDetails.type, "NfviDetailsType", "csharp");
@@clientName(PodEvent.type, "EventType", "csharp");
@@clientName(Deployment.desired, "DesiredNumberOfPods", "csharp");
@@clientName(Deployment.ready, "ReadyNumberOfPods", "csharp");
@@clientName(Deployment.upToDate, "UpToDateNumberOfPods", "csharp");
@@clientName(Deployment.available, "AvailableNumberOfPods", "csharp");
@@clientName(Pod.desired, "DesiredNumberOfContainers", "csharp");
@@clientName(Pod.ready, "ReadyNumberOfContainers", "csharp");
@@clientName(ReplicaSet.desired, "DesiredNumberOfPods", "csharp");
@@clientName(ReplicaSet.ready, "ReadyNumberOfPods", "csharp");
@@clientName(ReplicaSet.current, "CurrentNumberOfPods", "csharp");
@@clientName(StatefulSet.desired, "DesiredNumberOfPods", "csharp");
@@clientName(StatefulSet.ready, "ReadyNumberOfPods", "csharp");
@@clientName(DaemonSet.desired, "DesiredNumberOfPods", "csharp");
@@clientName(DaemonSet.current, "CurrentNumberOfPods", "csharp");
@@clientName(DaemonSet.ready, "ReadyNumberOfPods", "csharp");
@@clientName(DaemonSet.upToDate, "UpToDateNumberOfPods", "csharp");
@@clientName(DaemonSet.available, "AvailableNumberOfPods", "csharp");
@@alternateType(ReferencedResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(networkServiceDesignVersionPropertiesFormat.configurationGroupSchemaReferences,
  "ReferencedConfigurationGroupSchemas",
  "csharp"
);
@@clientName(SiteNetworkServicePropertiesFormat.desiredStateConfigurationGroupValueReferences,
  "DesiredStateConfigurationGroupValueReferencedResources",
  "csharp"
);
@@clientName(SiteNetworkServicePropertiesFormat.lastStateConfigurationGroupValueReferences,
  "LastStateConfigurationGroupValueReferencedResources",
  "csharp"
);
@@clientName(SitePropertiesFormat.siteNetworkServiceReferences,
  "ReferencedSiteNetworkServices",
  "csharp"
);
@@alternateType(NetworkFunctionPropertiesFormat.nfviId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(OpenDeploymentResourceReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SecretDeploymentResourceReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AzureStorageAccountContainerCredential.containerSasUri,
  url,
  "csharp"
);
@@alternateType(AzureStorageAccountCredential.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ArtifactStorePropertiesFormat.storageResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ArtifactStorePropertiesFormatManagedResourceGroupConfiguration.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(ManagedResourceGroupConfiguration.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(AzureCoreNFVIDetails.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(AzureArcK8sClusterNFVIDetails,
  "AzureArcK8SClusterNfviDetails",
  "csharp"
);
@@alternateType(AzureContainerRegistryScopedTokenCredential.acrServerUrl,
  url,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.ProxyResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.TrackedResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ProxyArtifactListOverview.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ProxyArtifactVersionsListOverview.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkFunction.etag, Azure.Core.eTag, "csharp");

@@clientName(NSDArtifactProfile, "NsdArtifactProfile", "java");
@@clientName(NFVIs, "NfvIs", "java");
@@clientName(AzureCoreNFVIDetails, "AzureCoreNfviDetails", "java");
@@clientName(AzureArcK8sClusterNFVIDetails,
  "AzureArcK8SClusterNfviDetails",
  "java,python"
);
@@clientName(AzureOperatorNexusClusterNFVIDetails,
  "AzureOperatorNexusClusterNfviDetails",
  "java"
);
@@clientName(VirtualNetworkFunctionNFVIType,
  "VirtualNetworkFunctionNfviType",
  "java"
);
@@clientName(ContainerizedNetworkFunctionNFVIType,
  "ContainerizedNetworkFunctionNfviType",
  "java"
);
@@clientName(VirtualNetworkFunctionNetworkFunctionDefinitionVersion,
  "VirtualNetworkFunctionDefinitionVersion",
  "java,python,go"
);

@@clientName(Microsoft.HybridNetwork,
  "HybridNetworkManagementClient",
  "python,javascript"
);
@@clientName(AzureArcK8sClusterNFVIDetails,
  "AzureArcK8SClusterNFVIDetails",
  "python"
);
@@clientName(NfviType, "NFVIType", "go");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op proxyArtifactUpdateState(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * The name of the publisher.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @segment("publishers")
  publisherName: string,

  /**
   * The name of the artifact store.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @segment("artifactStores")
  artifactStoreName: string,

  /**
   * The name of the artifact.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @maxLength(64)
  @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
  @query("artifactName")
  artifactName: string,

  /**
   * The name of the artifact version.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  @maxLength(64)
  @pattern("^[^\\s]*[^\\s]+[^\\s]*$")
  @segment("artifactVersions")
  artifactVersionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @body
  parameters: ArtifactChangeState,
): ArmResponse<ProxyArtifactVersionsListOverview> | ArmAcceptedLroResponse<
  "Request of updating artifact state is accepted.",
  ArmLroLocationHeader<FinalResult = ProxyArtifactVersionsListOverview>
> | ErrorResponse;

@@override(ProxyArtifact.updateState,
  proxyArtifactUpdateState,
  "go,javascript"
);
