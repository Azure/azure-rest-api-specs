import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.HybridNetwork;

@@clientName(HelmInstallOptions.wait, "waitOption", "java");
@@clientName(HelmUpgradeOptions.wait, "waitOption", "java");

// Mitigate breaks from TypeSpec migration
@@clientName(NSDArtifactProfile, "NsdArtifactProfile", "java");
@@clientName(NFVIs, "NfvIs", "java");
@@clientName(AzureCoreNFVIDetails, "AzureCoreNfviDetails", "java");
@@clientName(AzureArcK8sClusterNFVIDetails,
  "AzureArcK8SClusterNfviDetails",
  "java"
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
  "java"
);
