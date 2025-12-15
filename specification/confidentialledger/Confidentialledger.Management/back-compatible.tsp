import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ConfidentialLedger;

@@clientName(ConfidentialLedgers.create::parameters.resource,
  "confidentialLedger"
);
@@clientName(ConfidentialLedgers.update::parameters.properties,
  "confidentialLedger"
);
@@clientName(ConfidentialLedgers.backup::parameters.body, "confidentialLedger");
@@clientName(ConfidentialLedgers.restore::parameters.body,
  "confidentialLedger"
);

@@clientName(ManagedCCFs.create::parameters.resource, "ManagedCCF");
@@clientName(ManagedCCFs.update::parameters.properties, "ManagedCCF");
@@clientName(ManagedCCFs.backup::parameters.body, "ManagedCCF");
@@clientName(ManagedCCFs.restore::parameters.body, "ManagedCCF");
@@clientName(checkNameAvailability::parameters.body, "nameAvailabilityRequest");
@@clientLocation(ConfidentialLedgers.get, "Ledger");
@@clientLocation(ConfidentialLedgers.create, "Ledger");
@@clientLocation(ConfidentialLedgers.update, "Ledger");
@@clientLocation(ConfidentialLedgers.delete, "Ledger");
@@clientLocation(ConfidentialLedgers.listByResourceGroup, "Ledger");
@@clientLocation(ConfidentialLedgers.listBySubscription, "Ledger");
@@clientLocation(ConfidentialLedgers.backup, "Ledger");
@@clientLocation(ConfidentialLedgers.restore, "Ledger");
@@clientLocation(ManagedCCFs.get, "ManagedCCF");
@@clientLocation(ManagedCCFs.create, "ManagedCCF");
@@clientName(ManagedCCFs.create::parameters.resource, "ManagedCCF");
@@clientLocation(ManagedCCFs.update, "ManagedCCF");
@@clientName(ManagedCCFs.update::parameters.properties, "ManagedCCF");
@@clientLocation(ManagedCCFs.delete, "ManagedCCF");
@@clientLocation(ManagedCCFs.listByResourceGroup, "ManagedCCF");
@@clientLocation(ManagedCCFs.listBySubscription, "ManagedCCF");
@@clientLocation(ManagedCCFs.backup, "ManagedCCF");
@@clientName(ManagedCCFs.backup::parameters.body, "ManagedCCF");
@@clientLocation(ManagedCCFs.restore, "ManagedCCF");
@@clientName(ManagedCCFs.restore::parameters.body, "ManagedCCF");
