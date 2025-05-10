import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using MongoDB.Atlas;

@@clientName(MongoDB.Atlas, "MongoDBAtlasMgmt", "python");
// java
@@clientName(MongoDB.Atlas, "MongoDBAtlasManagementClient", "java");
