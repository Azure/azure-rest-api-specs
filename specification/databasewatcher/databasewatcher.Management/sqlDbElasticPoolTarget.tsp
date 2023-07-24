import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";
import "./baseTarget.tsp";

namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@doc("Properties specific to elastic pool in Azure SQL Database.")
model SqlDbElasticPoolTargetProperties extends TargetProperties {
  @doc("Azure SQL DB elastic pool target.")
  targetType: "SqlEp";

  @doc("ARM ResourceId of an Azure SQL DB elastic pool target.")
  sqlEpResourceId: string;

  @doc("ARM ResourceId of the anchor database used to connect to an elastic pool.")
  anchorDatabaseResourceId: string;

  @doc("Set to true to monitor a high availability replica of specified target, if any.")
  readIntent?: boolean = false;
}
