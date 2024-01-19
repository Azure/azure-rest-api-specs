import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
@doc("The top level data export resource container.")
@parentResource(Workspace)
model DataExport is ProxyResource<DataExportProperties> {
  @doc("The data export rule name.")
  @path
  @key("dataExportName")
  @segment("dataExports")
  name: string;
}

@armResourceOperations
interface DataExports {
  @doc("Gets a data export instance.")
  get is ArmResourceRead<DataExport>;

  @doc("Create or update a data export.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataExport>;

  @doc("Deletes the specified data export in a given workspace..")
  delete is ArmResourceDeleteSync<DataExport>;

  @doc("Lists the data export instances within a workspace.")
  listByWorkspace is ArmResourceListByParent<DataExport>;
}

@@projectedName(DataExports.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataExports.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataExports.createOrUpdate::parameters.resource,
  "The parameters required to create or update a data export."
);
