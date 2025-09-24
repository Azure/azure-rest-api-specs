import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Spatio;

@@clientName(Microsoft.Spatio, "PlanetaryComputerMgmt", "python");
@@clientName(Microsoft.Spatio, "PlanetaryComputerMgmtClient", "java");
@@clientName(Versions.`2024-01-31-preview`, "V20240131Preview", "javascript");
@@clientName(Versions.`2025-02-11-preview`, "V20250211Preview", "javascript");

// CSharp
@@clientName(GeoCatalog, "PlanetaryComputerGeoCatalog", "csharp");
@@clientName(GeoCatalogProperties,
  "PlanetaryComputerGeoCatalogProperties",
  "csharp"
);
@@clientName(CatalogTier, "PlanetaryComputerGeoCatalogTier", "csharp");
@@clientName(ProvisioningState, "PlanetaryComputerProvisioningState", "csharp");
@@alternateType(GeoCatalogUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(GeoCatalogProperties.catalogUri, url, "csharp");
