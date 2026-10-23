import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./baseTarget.tsp";

namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@doc("The properties specific to Azure SQL Managed Instance targets.")
model SqlMiTargetProperties extends TargetProperties {
  @doc("The Azure SQL Managed Instance target.")
  targetType: "SqlMi";

  @doc("The Azure resource ID of an Azure SQL Managed Instance target.")
  sqlMiResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/managedInstances";
    }
  ]>;

  @doc("The TCP port number to optionally use in the connection string when connecting to an Azure SQL Managed Instance target.")
  connectionTcpPort?: int32 = 1433;

  #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing SqlMiTargetProperties.readIntent has a boolean wire value; preserve the published property contract."
  @doc("Set to true to monitor a high availability replica of specified target, if any.")
  readIntent?: boolean = false;
}
