import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.KubernetesRuntime;

@@clientName(Microsoft.KubernetesRuntime,
  "ContainerOrchestratorRuntimeMgmt",
  "python"
);

@@clientName(AccessMode, "StorageClassAccessMode", "csharp");
@@clientName(AdvertiseMode.ARP, "Arp", "csharp");
@@clientName(AdvertiseMode.BGP, "Bgp", "csharp");
@@clientName(BgpPeer, "ConnectedClusterBgpPeer", "csharp");
@@clientName(BgpPeerProperties, "ConnectedClusterBgpPeerProperties", "csharp");
@@clientName(LoadBalancer, "ConnectedClusterLoadBalancer", "csharp");
@@clientName(LoadBalancerProperties,
  "ConnectedClusterLoadBalancerProperties",
  "csharp"
);
@@clientName(ServiceResource, "ConnectedClusterService", "csharp");
@@clientName(ServiceProperties, "ConnectedClusterServiceProperties", "csharp");
@@clientName(StorageClassResource, "ConnectedClusterStorageClass", "csharp");
@@clientName(StorageClassProperties,
  "ConnectedClusterStorageClassProperties",
  "csharp"
);
@@clientName(ProvisioningState,
  "ContainerOrchestratorProvisioningState",
  "csharp"
);
@@clientName(SCType, "StorageClassType", "csharp");
@@clientName(SCType.RWX, "Rwx", "csharp");
@@clientName(SCType.NFS, "Nfs", "csharp");
@@clientName(SCType.SMB, "Smb", "csharp");
