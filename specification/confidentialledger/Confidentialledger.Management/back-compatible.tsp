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
