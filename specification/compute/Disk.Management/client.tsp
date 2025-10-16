import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

// Mitigate breaking changes for Java SDK migration from Swagger to TypeSpec

// Property name changes - diskIOPS properties should be lowercase "iops" for Java compatibility
@@clientName(DiskProperties.diskIOPSReadWrite, "diskIopsReadWrite", "java");
@@clientName(DiskProperties.diskIOPSReadOnly, "diskIopsReadOnly", "java");
@@clientName(DiskUpdateProperties.diskIOPSReadWrite,
  "diskIopsReadWrite",
  "java"
);
@@clientName(DiskUpdateProperties.diskIOPSReadOnly, "diskIopsReadOnly", "java");

// Property name changes - AccessUri SAS properties should be lowercase "sas" for Java compatibility
@@clientName(AccessUri.accessSAS, "accessSas", "java");
@@clientName(AccessUri.securityDataAccessSAS, "securityDataAccessSas", "java");
@@clientName(AccessUri.securityMetadataAccessSAS,
  "securityMetadataAccessSas",
  "java"
);

// Property name changes - GrantAccessData SAS property should be lowercase "sas" for Java compatibility
@@clientName(GrantAccessData.getSecureVMGuestStateSAS,
  "getSecureVMGuestStateSas",
  "java"
);

@@clientName(DiskSecurityTypes.ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey,
  "ConfidentialVMVmguestStateOnlyEncryptedWithPlatformKey",
  "go"
);
