import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.HybridNetwork;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

@@clientName(HelmInstallOptions.wait, "waitOption", "java");
@@clientName(HelmUpgradeOptions.wait, "waitOption", "java");

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
