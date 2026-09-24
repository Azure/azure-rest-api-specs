import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProgrammableConnectivity;

@@clientName(
  Microsoft.ProgrammableConnectivity,
  "ProgrammableConnectivityMgmt",
  "python"
);
@@clientName(
  Microsoft.ProgrammableConnectivity,
  "ProgrammableConnectivityMgmtClient",
  "java"
);

// Apply .NET-specific names that provide sufficient domain context in the public API.
@@clientName(Gateway, "ProgrammableConnectivityGateway", "csharp");
@@clientName(
  GatewayProperties,
  "ProgrammableConnectivityGatewayProperties",
  "csharp"
);
@@clientName(
  ApplicationOwnerProperties,
  "GatewayApplicationOwnerProperties",
  "csharp"
);
@@clientName(ApplicationProperties, "GatewayApplicationProperties", "csharp");
@@clientName(Person, "ApplicationContactPerson", "csharp");
@@clientName(GeographicAddress, "ApplicationGeographicAddress", "csharp");
@@clientName(LocalRepresentative, "ApplicationLocalRepresentative", "csharp");
@@clientName(Category, "ProgrammableConnectivityApplicationCategory", "csharp");
@@clientName(OrganizationType, "ApplicationOwnerOrganizationType", "csharp");
@@clientName(DataProcessing, "OperatorApiConnectionDataProcessing", "csharp");
@@clientName(DataRegions, "OperatorApiConnectionDataRegion", "csharp");
@@clientName(Frequency, "DataProcessingFrequency", "csharp");
@@clientName(Duration, "DataProcessingDuration", "csharp");
@@clientName(Context, "DataProcessingContext", "csharp");
@@clientName(ProcessingOperation, "DataProcessingOperation", "csharp");
@@clientName(Purpose, "OperatorApiConnectionPurpose", "csharp");
@@clientName(Status, "OperatorApiConnectionStatus", "csharp");
@@clientName(
  ProvisioningState,
  "ProgrammableConnectivityProvisioningState",
  "csharp"
);
@@clientName(
  MarketplaceProperties,
  "OperatorApiPlanMarketplaceProperties",
  "csharp"
);
@@clientName(DataRegions.commercialActivity, "IsCommercialActivity", "csharp");
@@clientName(
  OperatorApiConnectionProperties.planTermsAndConditionsAccepted,
  "IsPlanTermsAndConditionsAccepted",
  "csharp"
);
