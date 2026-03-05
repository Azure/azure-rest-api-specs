import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedNetworkFabric;

@@clientName(Microsoft.ManagedNetworkFabric.IPAddressType,
  "IpAddressType",
  "java"
);

@@clientName(Microsoft.ManagedNetworkFabric.NetworkFabricProperties.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.NetworkFabricPatchProperties.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.BgpConfiguration.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.BgpPatchConfiguration.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.ExternalNetworkPropertiesOptionAProperties.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.ExternalNetworkPatchPropertiesOptionAProperties.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.OptionBLayer3Configuration.fabricASN,
  "fabricAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.OptionBLayer3ConfigurationPatchProperties.fabricASN,
  "fabricAsn",
  "java"
);

@@clientName(Microsoft.ManagedNetworkFabric.BgpConfiguration.peerASN,
  "peerAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.BgpPatchConfiguration.peerASN,
  "peerAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.ExternalNetworkPropertiesOptionAProperties.peerASN,
  "peerAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.ExternalNetworkPatchPropertiesOptionAProperties.peerASN,
  "peerAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.OptionBLayer3Configuration.peerASN,
  "peerAsn",
  "java"
);
@@clientName(Microsoft.ManagedNetworkFabric.OptionBLayer3ConfigurationPatchProperties.peerASN,
  "peerAsn",
  "java"
);
