import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.DBforPostgreSQL;
using Azure.ClientGenerator.Core;

@@clientName(Migration, "MigrationResource", "java");
@@clientName(VirtualEndpoint, "VirtualEndpointResource", "java");
@@clientName(AdministratorMicrosoftEntra,
  "ActiveDirectoryAdministrator",
  "java"
);
