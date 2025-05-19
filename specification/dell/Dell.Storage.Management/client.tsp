import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Dell.Storage, "DellStorageMgmt", "python");
@@clientName(Dell.Storage, "DellStorageMgmtClient", "java");
