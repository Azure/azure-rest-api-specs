import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.DatabaseFleetManager;

@@clientName(Fleet, "DatabaseFleet", "csharp");
@@clientName(Fleetspace, "DatabaseFleetspace", "csharp");

@@clientName(Identity, "FleetDatabaseIdentityProperties", "csharp");
@@clientName(IdentityType, "DatabaseFleetManagerIdentityType", "csharp");
@@clientName(PrincipalType, "DatabaseFleetManagerPrincipalType", "csharp");
@@clientName(ResourceType, "DatabaseFleetResourceKind", "csharp");
@@clientName(ZoneRedundancy, "DatabaseFleetManagerZoneRedundancy", "csharp");

@@clientName(RegisterServerDefinition, "RegisterServerContent", "csharp");
@@clientName(
  DatabaseChangeTierDefinition,
  "DatabaseChangeTierContent",
  "csharp"
);
@@clientName(DatabaseRenameDefinition, "DatabaseRenameContent", "csharp");

@@clientName(FleetDatabaseProperties.recoverable, "IsRecoverable", "csharp");
@@clientName(FleetTierProperties.disabled, "IsDisabled", "csharp");
@@clientName(FleetTierProperties.serverless, "IsServerless", "csharp");
@@clientName(FleetTierProperties.pooled, "IsPooled", "csharp");

@@clientName(
  TransparentDataEncryption,
  "DatabaseFleetManagerTransparentDataEncryption",
  "csharp"
);
@@clientName(MainPrincipal, "FleetAdministrator", "csharp");
