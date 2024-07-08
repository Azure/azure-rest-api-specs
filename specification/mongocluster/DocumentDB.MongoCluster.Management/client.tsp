import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.DocumentDB;

@@clientName(Microsoft.DocumentDB, "MongoClusterMgmtClient", "python");
@@access(Operations.list, Access.internal, "csharp");
