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

@@clientName(ManagedCCFS.create::parameters.resource, "ManagedCCF");
@@clientName(ManagedCCFS.update::parameters.properties, "ManagedCCF");
@@clientName(ManagedCCFS.backup::parameters.body, "ManagedCCF");
@@clientName(ManagedCCFS.restore::parameters.body, "ManagedCCF");
