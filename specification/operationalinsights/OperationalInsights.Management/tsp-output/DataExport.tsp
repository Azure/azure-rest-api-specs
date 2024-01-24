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
/**
 * The top level data export resource container.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Workspace)
@Azure.ResourceManager.Private.armResourceInternal(DataExportProperties)
@includeInapplicableMetadataInPayload(false)
model DataExport extends ProxyResourceBase {
  /**
   * The data export rule name.
   */
  @path
  @key("dataExportName")
  @segment("dataExports")
  name: string;

  /**
   * data export properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DataExportProperties;
}

@armResourceOperations
interface DataExports {
  /**
   * Gets a data export instance.
   */
  get is ArmResourceRead<DataExport>;

  /**
   * Create or update a data export.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataExport>;

  /**
   * Deletes the specified data export in a given workspace..
   */
  delete is ArmResourceDeleteSync<DataExport>;

  /**
   * Lists the data export instances within a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataExports_ListByWorkspace")
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
