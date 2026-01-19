/**
 * Client customizations for Discovery.Bookshelf SDK generation.
 *
 * This file addresses .NET naming conflicts (AZC0012/AZC0034) for shared types.
 */
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// =============================================================================
// Client name customizations to avoid .NET naming conflicts (AZC0012/AZC0034)
// =============================================================================

// Shared types - AZC0012 (generic) and AZC0034 (conflicts with Azure types)
@@clientName(Microsoft.Discovery.DataPlane.Shared.Tag,
  "BookshelfTag",
  "csharp"
);
@@clientName(Microsoft.Discovery.DataPlane.Shared.ProvisioningState,
  "BookshelfProvisioningState",
  "csharp"
);
