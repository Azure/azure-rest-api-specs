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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Workspace)
@Http.Private.includeInapplicableMetadataInPayload(false)
model DataSource extends Foundations.ProxyResource {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: unknown;

  @visibility(Lifecycle.Read)
  @path
  @key("dataSourceName")
  @segment("dataSources")
  name: string;

  /**
   * The ETag of the data source.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * The kind of the DataSource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind: DataSourceKind;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
