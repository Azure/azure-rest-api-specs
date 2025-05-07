import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MongoDB.Atlas;

@@clientName(Microsoft.Edge,
  "SiteManagerMgmt",
  "python"
);
