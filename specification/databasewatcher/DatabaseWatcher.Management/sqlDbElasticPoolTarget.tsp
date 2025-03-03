import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./baseTarget.tsp";

namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@doc("The properties specific to an elastic pool in Azure SQL Database.")
model SqlDbElasticPoolTargetProperties extends TargetProperties {
  @doc("The Azure SQL DB elastic pool target.")
  targetType: "SqlEp";

  @doc("The Azure resource ID of an Azure SQL DB elastic pool target.")
  sqlEpResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/elasticPools";
    }
  ]>;

  @doc("The Azure resource ID of the anchor database used to connect to an elastic pool.")
  anchorDatabaseResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>;

  @doc("Set to true to monitor a high availability replica of specified target, if any.")
  readIntent?: boolean = false;
}
