import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Attestation;

@@clientName(Microsoft.Attestation,
  "AttestationManagementClient",
  "javascript"
);
@@clientName(Microsoft.Attestation,
  "AttestationManagementClient",
  "python"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id, armResourceIdentifier, "csharp");

// this is temporary before our generator fixes this issue.
@@scope(Operations.list, "!csharp");
