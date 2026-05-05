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
