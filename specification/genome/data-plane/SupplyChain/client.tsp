import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Operation names
@@clientName(Genome.getNTierSuppliersWithFilters,
  "GetNTierSuppliersWithFilters"
);
@@clientName(Genome.getNTierSuppliers, "GetNTierSuppliers");

// Model name standardization
@@clientName(Genome.SearchNtierSuppliersResponse,
  "SearchNTierSuppliersResponse"
);
@@clientName(Genome.NtierSuppliersResponse, "NTierSuppliersResponse");
@@clientName(Genome.NtierSupplierRelationship, "NTierSupplierRelationship");

// Model renames for .NET SDK naming conventions (AZC0030, AZC0034, AZC0012)
@@clientName(Genome.SupplierListResponse, "SupplierList", "csharp");
@@clientName(Genome.SupplierResponse, "GenomeSupplier", "csharp");
@@clientName(Genome.SearchNtierSuppliersResponse,
  "SearchNTierSuppliers",
  "csharp"
);
@@clientName(Genome.SupplierWithDepthResponse, "SupplierWithDepth", "csharp");
@@clientName(Genome.NtierSuppliersResponse, "NTierSuppliers", "csharp");
@@clientName(Genome.ErrorResponse, "GenomeError", "csharp");
@@clientName(Genome.SearchResultsResponse, "SearchResults", "csharp");
