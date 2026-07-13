import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// The following model/enum types are generated with single, generic names that
// trigger the .NET analyzers AZC0012 (single-word type name -> collision risk)
// and AZC0030 (discouraged type-name suffix such as "Collection"/"Response").
// Rename them for the C# SDK only so it follows the Azure SDK for .NET naming
// guidelines. The scope is limited to "csharp" so the REST/wire contract and the
// already-generated JavaScript, Python and Java SDKs are left unchanged.

// AZC0012: single, generic type names.
@@clientName(ConfidentialLedger.Bundle, "LedgerBundle", "csharp");
@@clientName(ConfidentialLedger.Constitution, "LedgerConstitution", "csharp");
@@clientName(ConfidentialLedger.Metadata, "LedgerEndpointMetadata", "csharp");
@@clientName(ConfidentialLedger.Mode, "LedgerEndpointMode", "csharp");
@@clientName(ConfidentialLedger.Role, "LedgerRole", "csharp");

// AZC0012 + AZC0030: single, generic name that also ends with "Collection".
@@clientName(ConfidentialLedger.Collection, "LedgerCollectionInfo", "csharp");

// AZC0030: type name ends with the discouraged "Response" suffix.
@@clientName(ConfidentialLedger.UserDefinedFunctionExecutionResponse,
  "UserDefinedFunctionExecution",
  "csharp"
);
