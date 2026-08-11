import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HybridContainerService;

@@clientName(VmSkuProfiles.getVMSkus, "getVmSkus", "autorest");
@@clientName(VmSkuProfiles.createVMSkus, "createVmSkus", "autorest");
@@clientName(VmSkuProfiles.deleteVMSkus, "deleteVmSkus", "autorest");
