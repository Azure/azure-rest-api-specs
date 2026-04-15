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
 * The top level data export resource container.
 */
@parentResource(Workspace)
model DataExport is Azure.ResourceManager.ProxyResource<DataExportProperties> {
  ...ResourceNameParameter<
    Resource = DataExport,
    KeyName = "dataExportName",
    SegmentName = "dataExports",
    NamePattern = ""
  >;
}

@armResourceOperations(#{omitTags: true})
interface DataExports {
  /**
   * Gets a data export instance.
   */
  @tag("DataExport")
  get is ArmResourceRead<DataExport>;

  /**
   * Create or update a data export.
   */
  @tag("DataExport")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataExport>;

  /**
   * Deletes the specified data export in a given workspace..
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @tag("DataExport")
  delete is ArmResourceDeleteSync<DataExport, Response = ArmDeletedResponse>;

  /**
   * Lists the data export instances within a workspace.
   */
  @tag("DataExport")
  listByWorkspace is ArmResourceListByParent<
    DataExport,
    Response = ArmResponse<DataExportListResult>
  >;
}

@@doc(DataExport.name, "The data export rule name.");
@@doc(DataExport.properties, "data export properties.");
@@doc(DataExports.createOrUpdate::parameters.resource,
  "The parameters required to create or update a data export."
);
