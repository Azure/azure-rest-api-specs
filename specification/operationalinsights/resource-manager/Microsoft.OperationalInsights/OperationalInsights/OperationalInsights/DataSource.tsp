import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * Datasources under OMS Workspace.
 */
@parentResource(Workspace)
model DataSource is Azure.ResourceManager.ProxyResource<never> {
  ...ResourceNameParameter<
    Resource = DataSource,
    KeyName = "dataSourceName",
    SegmentName = "dataSources",
    NamePattern = ""
  >;

  /**
   * The ETag of the data source.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The kind of the DataSource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: DataSourceKind;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface DataSources {
  /**
   * Gets a datasource instance.
   */
  get is ArmResourceRead<DataSource>;

  /**
   * Create or update a data source.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataSource>;

  /**
   * Deletes a data source instance.
   */
  delete is ArmResourceDeleteSync<DataSource>;

  /**
   * Gets the first page of data source instances in a workspace with the link to the next page.
   */
  listByWorkspace is ArmResourceListByParent<
    DataSource,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter: string;

      /**
       * Starting point of the collection of data source instances.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@doc(DataSource.name, "Name of the datasource");
@@doc(DataSource.properties,
  "The data source properties in raw json format, each kind of data source have it's own schema."
);
@@doc(DataSources.createOrUpdate::parameters.resource,
  "The parameters required to create or update a datasource."
);
