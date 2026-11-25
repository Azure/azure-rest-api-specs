import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DigitalAssets;

@@clientName(Microsoft.DigitalAssets, "DigitalAssetsMgmtClient", "python");

@@clientName(EvmContractAddress, "EVMContractAddress", "go");

@@clientName(ZkpRollupProperties, "ZKPRollupProperties", "go");
@@clientName(ZkpRollupPatchProperties, "ZKPRollupPatchProperties", "go");
@@clientName(ZkpRollupIdentityUpdate, "ZKPRollupIdentityUpdate", "go");
@@clientName(ZkpRollupUpdate, "ZKPRollupUpdate", "go");
@@clientName(ZkpRollup, "ZKPRollup", "go");
@@clientName(ZkpRollups, "ZKPRollups", "go");

@@clientName(
  ZkpRollupProperties.customerVpnPublicIp,
  "CustomerVPNPublicIP",
  "go"
);
@@clientName(
  ZkpRollupProperties.serviceVpnPublicIp,
  "ServiceVPNPublicIP",
  "go"
);
@@clientName(
  ZkpRollupProperties.serviceVpnAddressSpace,
  "ServiceVPNAddressSpace",
  "go"
);
@@clientName(ZkpRollupProperties.bootNodeIp, "BootNodeIP", "go");
@@clientName(ZkpRollupProperties.bootNodeP2pPort, "BootNodeP2PPort", "go");
@@clientName(ZkpRollupProperties.bootNodeRpcPort, "BootNodeRPCPort", "go");
@@clientName(ZkpRollupPatchProperties.bootNodeIp, "BootNodeIP", "go");
@@clientName(
  ZkpRollupPatchProperties.bootNodeP2pPort,
  "BootNodeP2PPort",
  "go"
);
@@clientName(
  ZkpRollupPatchProperties.bootNodeRpcPort,
  "BootNodeRPCPort",
  "go"
);
