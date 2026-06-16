import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ConfidentialLedger;

// Mitigate breaking change: "AadBasedSecurityPrincipal" was renamed to "AADBasedSecurityPrincipal"
@@clientName(Microsoft.ConfidentialLedger.AADBasedSecurityPrincipal,
  "AadBasedSecurityPrincipal",
  "java"
);

// Mitigate breaking change: rename "ManagedCCFs" to "ManagedCcfs" operation group name for Java
@@clientLocation(ManagedCCFs.get, "ManagedCcfs", "java");
@@clientLocation(ManagedCCFs.create, "ManagedCcfs", "java");
@@clientLocation(ManagedCCFs.update, "ManagedCcfs", "java");
@@clientLocation(ManagedCCFs.delete, "ManagedCcfs", "java");
@@clientLocation(ManagedCCFs.listByResourceGroup, "ManagedCcfs", "java");
@@clientLocation(ManagedCCFs.listBySubscription, "ManagedCcfs", "java");
@@clientLocation(ManagedCCFs.backup, "ManagedCcfs", "java");
@@clientLocation(ManagedCCFs.restore, "ManagedCcfs", "java");

// Mitigate breaking change: rename "CCF" to "Ccf" in model names for Java
@@clientName(ManagedCCF, "ManagedCcf", "java");
@@clientName(ManagedCCFProperties, "ManagedCcfProperties", "java");
@@clientName(ManagedCCFBackup, "ManagedCcfBackup", "java");
@@clientName(ManagedCCFBackupResponse, "ManagedCcfBackupResponse", "java");
@@clientName(ManagedCCFRestore, "ManagedCcfRestore", "java");
@@clientName(ManagedCCFRestoreResponse, "ManagedCcfRestoreResponse", "java");

@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "ConfidentialLedgerNameAvailabilityContent",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "ConfidentialLedgerNameAvailabilityResult",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "ConfidentialLedgerNameUnavailableReason",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@clientName(LedgerProperties, "ConfidentialLedgerProperties", "csharp");
@@clientName(LedgerRoleName, "ConfidentialLedgerRoleName", "csharp");
@@clientName(LedgerType, "ConfidentialLedgerType", "csharp");
@@clientName(ProvisioningState,
  "ConfidentialLedgerProvisioningState",
  "csharp"
);
@@clientName(LedgerSku, "ConfidentialLedgerSku", "csharp");
@@clientName(ConfidentialLedgerFilesExport,
  "ConfidentialLedgerFilesExportContent",
  "csharp"
);
@@clientName(ConfidentialLedgerFilesExportResponse,
  "ConfidentialLedgerFilesExportResult",
  "csharp"
);
@@alternateType(AADBasedSecurityPrincipal.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(AADBasedSecurityPrincipal.principalId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(LedgerProperties.ledgerUri, url, "csharp");
@@alternateType(LedgerProperties.identityServiceUri, url, "csharp");
@@alternateType(ConfidentialLedgerFilesExport.uri, url, "csharp");
@@clientName(RunningState, "ConfidentialLedgerRunningState", "csharp");
@@clientName(ApplicationType, "ConfidentialLedgerApplicationType", "csharp");
@@clientName(EnclavePlatform, "ConfidentialLedgerEnclavePlatform", "csharp");
@@clientName(Microsoft.ConfidentialLedger.checkNameAvailability,
  "CheckConfidentialLedgerNameAvailability",
  "csharp"
);
@@clientName(AADBasedSecurityPrincipal, "AadBasedSecurityPrincipal", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
