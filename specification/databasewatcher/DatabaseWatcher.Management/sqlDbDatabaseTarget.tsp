import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./baseTarget.tsp";

namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@doc("The properties specific to single database in Azure SQL Database.")
model SqlDbSingleDatabaseTargetProperties extends TargetProperties {
  @doc("The Azure SQL DB single database target.")
  targetType: "SqlDb";

  @doc("The Azure ResourceId of an Azure SQL DB single database target.")
  sqlDbResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>;

  @doc("Set to true to monitor a high availability replica of specified target, if any.")
  readIntent?: boolean = false;
}
