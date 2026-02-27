import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Attestation,
  "AttestationManagementClient",
  "javascript"
);
@@clientName(Microsoft.Attestation, "AttestationManagementClient", "python");
