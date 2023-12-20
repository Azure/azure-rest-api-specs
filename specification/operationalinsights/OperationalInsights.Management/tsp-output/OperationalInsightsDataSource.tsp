import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./OperationalInsightsWorkspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("Datasources under OMS Workspace.")
@parentResource(OperationalInsightsWorkspace)
model OperationalInsightsDataSource is ProxyResource<AnyObject> {
  @doc("Name of the datasource")
  @path
  @key("dataSourceName")
  @segment("dataSources")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface OperationalInsightsDataSources {
  @doc("Gets a datasource instance.")
  get is ArmResourceRead<OperationalInsightsDataSource>;
  @doc("Create or update a data source.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<OperationalInsightsDataSource>;
  @doc("Deletes a data source instance.")
  delete is ArmResourceDeleteSync<OperationalInsightsDataSource>;
  @doc("Gets the first page of data source instances in a workspace with the link to the next page.")
  listByWorkspace is ArmResourceListByParent<
    OperationalInsightsDataSource,
    {
      ...BaseParameters<OperationalInsightsDataSource>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter: string;

      @doc("Starting point of the collection of data source instances.")
      @query("$skiptoken")
      skipToken?: string;
    }
  >;
}
