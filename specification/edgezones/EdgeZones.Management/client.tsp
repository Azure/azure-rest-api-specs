import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EdgeZones;

@@clientName(Microsoft.EdgeZones, "EdgeZonesMgmtClient", "python");

@@clientName(ProvisioningState, "EdgeZonesProvisioningState", "csharp");
@@clientName(RegistrationState, "EdgeZonesRegistrationState", "csharp");
