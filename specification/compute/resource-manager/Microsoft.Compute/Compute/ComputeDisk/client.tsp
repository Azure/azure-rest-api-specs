import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ComputeDisk;

@@clientName(
  DiskSecurityTypes.ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey,
  "ConfidentialVMVmguestStateOnlyEncryptedWithPlatformKey",
  "go,javascript"
);

// Property name changes - diskIOPS properties should be lowercase "iops" for Java compatibility
@@clientName(DiskProperties.diskIOPSReadWrite, "diskIopsReadWrite", "java");
@@clientName(DiskProperties.diskIOPSReadOnly, "diskIopsReadOnly", "java");
@@clientName(
  DiskUpdateProperties.diskIOPSReadWrite,
  "diskIopsReadWrite",
  "java"
);
@@clientName(DiskUpdateProperties.diskIOPSReadOnly, "diskIopsReadOnly", "java");

// Property name changes - AccessUri SAS properties should be lowercase "sas" for Java compatibility
@@clientName(AccessUri.accessSAS, "accessSas", "java");
@@clientName(AccessUri.securityDataAccessSAS, "securityDataAccessSas", "java");
@@clientName(
  AccessUri.securityMetadataAccessSAS,
  "securityMetadataAccessSas",
  "java"
);

// Property name changes - GrantAccessData SAS property should be lowercase "sas" for Java compatibility
@@clientName(
  GrantAccessData.getSecureVMGuestStateSAS,
  "getSecureVMGuestStateSas",
  "java"
);

// C# naming fixes for Azure.ResourceManager.Compute 1.15.0 stable API review.
@@clientName(ConfidentialVMVersion, "ConfidentialVmVersion", "csharp");
@@clientName(
  DiskSecurityProfile.confidentialVMVersion,
  "ConfidentialVmVersion",
  "csharp"
);
@@clientName(ImmutabilityPolicyData, "ImmutabilityPolicyContent", "csharp");
@@clientName(
  ImmutabilityPolicyLockData,
  "ImmutabilityPolicyLockContent",
  "csharp"
);
@@clientName(
  Snapshots.updateImmutabilityPolicy::parameters.body,
  "content",
  "csharp"
);
@@clientName(
  Snapshots.updateImmutabilityPolicyLock::parameters.body,
  "content",
  "csharp"
);
