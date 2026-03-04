import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ConfidentialLedger;

// Mitigate breaking change: "AadBasedSecurityPrincipal" was renamed to "AADBasedSecurityPrincipal"
@@clientName(Microsoft.ConfidentialLedger.AADBasedSecurityPrincipal,
  "AadBasedSecurityPrincipal",
  "java"
);
