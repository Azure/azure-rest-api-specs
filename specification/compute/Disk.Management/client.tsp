import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Compute, "ComputeManagementClient", "javascript");
@@clientName(Microsoft.Compute.DiskSecurityTypes.ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey,
  "ConfidentialVMVmguestStateOnlyEncryptedWithPlatformKey",
  "javascript"
);
