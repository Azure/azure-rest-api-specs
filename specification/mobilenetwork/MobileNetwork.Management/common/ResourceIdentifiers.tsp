import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@doc("Reference to a Nexus Trunked Network resource.")
@extension("x-ms-azure-resource", true)
model NexusTrunkedNetworkResourceId {
  @doc("Nexus Trunked Network resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/trunkedNetworks";
    }
  ]>;
}

@doc("Reference to an Edge Virtual Network")
@extension("x-ms-azure-resource", true)
model EdgeVirtualNetworkResourceId {
  @doc("Edge Virtual Network resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/packetCoreControlPlanes/packetCoreDataPlanes/edgeVirtualNetworks";
    }
  ]>;
}

@doc("Reference to an Edge Network Security Group Resource")
@extension("x-ms-azure-resource", true)
model EdgeNetworkSecurityGroupResourceId {
  @doc("Edge Network Security Group Resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/edgeNetworkSecurityGroups";
    }
  ]>;
}

@doc("Reference to a site resource.")
@extension("x-ms-azure-resource", true)
model SiteResourceId {
  @doc("Site resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/sites";
    }
  ]>;
}

@doc("Reference to an Azure Stack Edge device resource.")
@extension("x-ms-azure-resource", true)
model AzureStackEdgeDeviceResourceId {
  @doc("Azure Stack Edge device resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.DataBoxEdge/dataBoxEdgeDevices";
    }
  ]>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility."
@doc("Reference to an Azure Stack HCI cluster resource.")
@extension("x-ms-azure-resource", true)
model AzureStackHCIClusterResourceId {
  @doc("Azure Stack HCI cluster resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/clusters";
    }
  ]>;
}

@doc("Reference to a Nexus Edge Cluster resource.")
@extension("x-ms-azure-resource", true)
model NexusEdgeClusterResourceId {
  @doc("Nexus Edge Cluster resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/edgeClusters";
    }
  ]>;
}

@doc("Reference to an Azure Arc custom location resource.")
@extension("x-ms-azure-resource", true)
model ConnectedClusterResourceId {
  @doc("Azure Arc custom location resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters";
    }
  ]>;
}

@doc("Reference to an Azure Arc custom location resource.")
@extension("x-ms-azure-resource", true)
model CustomLocationResourceId {
  @doc("Azure Arc custom location resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;
}

@doc("Reference to a Nexus Cloud Services Network resource.")
@extension("x-ms-azure-resource", true)
model NexusCloudServicesNetworkResourceId {
  @doc("Nexus Cloud Services Network resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/cloudServicesNetworks";
    }
  ]>;
}

@doc("Reference to a Nexus L3 Network resource.")
@extension("x-ms-azure-resource", true)
model NexusL3NetworkResourceId {
  @doc("Nexus L3 Network resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/l3Networks";
    }
  ]>;
}

@doc("Reference to an attached data network resource.")
@extension("x-ms-azure-resource", true)
model AttachedDataNetworkResourceId {
  @doc("Attached data network resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/packetCoreControlPlanes/packetCoreDataPlanes/attachedDataNetworks";
    }
  ]>;
}

@doc("Reference to a SIM policy resource.")
@extension("x-ms-azure-resource", true)
model SimPolicyResourceId {
  @doc("SIM policy resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/simPolicies";
    }
  ]>;
}

@doc("Reference to a slice resource.")
@extension("x-ms-azure-resource", true)
model SliceResourceId {
  @doc("Slice resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/slices";
    }
  ]>;
}

@doc("Reference to a SIM group resource.")
@extension("x-ms-azure-resource", true)
model SimGroupResourceId {
  @doc("SIM group resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/simGroups";
    }
  ]>;
}

@doc("Reference to a mobile network resource.")
@extension("x-ms-azure-resource", true)
model MobileNetworkResourceId {
  @doc("Mobile network resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks";
    }
  ]>;
}

@doc("Reference to a data network resource.")
@extension("x-ms-azure-resource", true)
model DataNetworkResourceId {
  @doc("Data network resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/dataNetworks";
    }
  ]>;
}

@doc("Reference to a service resource.")
@extension("x-ms-azure-resource", true)
model ServiceResourceId {
  @doc("Service resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/services";
    }
  ]>;
}

@doc("Reference to an packet core control plane resource.")
@extension("x-ms-azure-resource", true)
model PacketCoreControlPlaneResourceId {
  @doc("Packet core control plane resource ID.")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/packetCoreControlPlanes";
    }
  ]>;
}

@doc("Reference to a cluster service resource.")
scalar ClusterServiceIdProperty
  extends armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/clusterServices",
    }
  ]>;

@doc("Reference to an Azure Arc custom location resource.")
scalar CustomLocationIdProperty
  extends armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations",
    }
  ]>;

@added(Versions.v2024_05_15_preview)
@doc("Reference to a Virtual Network Function (VNF) agent deployment resource.")
scalar VnfAgentDeploymentIdProperty
  extends armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/vnfAgentDeployments",
    }
  ]>;

@added(Versions.v2024_05_15_preview)
@doc("Azure resource ID of a User Assigned Managed Identity.")
scalar UamiIdPropertyIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities",
    }
  ]>;

@added(Versions.v2024_05_15_preview)
@doc("Azure resource ID of workload associated with a cluster.")
scalar AssociatedClusterWorkloadIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/amfDeployments",
    },
    {
      type: "Microsoft.MobileNetwork/nrfDeployments",
    },
    {
      type: "Microsoft.MobileNetwork/nssfDeployments",
    },
    {
      type: "Microsoft.MobileNetwork/observabilityServices",
    },
    {
      type: "Microsoft.MobileNetwork/smfDeployments",
    },
    {
      type: "Microsoft.MobileNetwork/upfDeployments",
    },
    {
      type: "Microsoft.MobileNetwork/vnfAgentDeployments",
    },
    {
      type: "Microsoft.MobileNetwork/sdmDeployments",
    }
  ]>;

@added(Versions.v2024_05_15_preview)
@doc("Azure resource ID of a Virtualized Network Function (VNF) associated with a Virtual Network Function (VNF) Agent")
scalar AssociatedVirtualNetworkFunctionIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/virtualizedMmeDeployments",
    }
  ]>;
