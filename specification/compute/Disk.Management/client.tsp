import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientName(DiskSecurityTypes.ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey,
  "ConfidentialVMVmguestStateOnlyEncryptedWithPlatformKey",
  "go"
);
