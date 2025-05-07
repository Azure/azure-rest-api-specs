import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./baseTarget.tsp";

namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

@doc("The properties specific to Azure SQL VM targets.")
@removed(Versions.v2025_01_02)
model SqlVmTargetProperties extends TargetProperties {
  @doc("The Azure SQL VM target.")
  targetType: "SqlVm";

  @doc("The Azure resource ID of an Azure SQL VM target.")
  sqlVmResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SqlVirtualMachine/sqlVirtualMachines";
    }
  ]>;

  @doc("The TCP port number to optionally use in the connection string when connecting to an Azure SQL VM target.")
  connectionTcpPort?: int32 = 1433;

  @doc("The SQL instance name to optionally use in the connection string when connecting to an Azure SQL VM target.")
  sqlNamedInstanceName?: string;
}
