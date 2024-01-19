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
@doc("Datasources under OMS Workspace.")
@parentResource(Workspace)
model DataSource is ProxyResource<AnyObject> {
  @doc("Name of the datasource")
  @path
  @key("dataSourceName")
  @segment("dataSources")
  name: string;

  @doc("The ETag of the data source.")
  etag?: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataSources {
  @doc("Gets a datasource instance.")
  get is ArmResourceRead<DataSource>;

  @doc("Create or update a data source.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataSource>;

  @doc("Deletes a data source instance.")
  delete is ArmResourceDeleteSync<DataSource>;

  @doc("Gets the first page of data source instances in a workspace with the link to the next page.")
  listByWorkspace is ArmResourceListByParent<
    DataSource,
    {
      ...BaseParameters<DataSource>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter: string;

      @doc("Starting point of the collection of data source instances.")
      @query("$skiptoken")
      skipToken?: string;
    }
  >;
}

@@projectedName(DataSources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataSources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataSources.createOrUpdate::parameters.resource,
  "The parameters required to create or update a datasource."
);
