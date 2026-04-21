import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ImportSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * An machine resource belonging to a site resource.
 */
@parentResource(ImportSite)
model ImportMachine
  is Azure.ResourceManager.ProxyResource<ImportMachineProperties> {
  ...ResourceNameParameter<
    Resource = ImportMachine,
    KeyName = "machineName",
    SegmentName = "machines"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ImportMachines {
  /**
   * Get a ImportMachine
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportMachinesController")
  @operationId("ImportMachinesController_Get")
  get is ArmResourceRead<ImportMachine>;

  /**
   * Delete a ImportMachine
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportMachinesController")
  @operationId("ImportMachinesController_Delete")
  delete is ArmResourceDeleteSync<ImportMachine>;

  /**
   * List ImportMachine resources by ImportSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportMachinesController")
  @operationId("ImportMachinesController_ListByImportSite")
  listByImportSite is ArmResourceListByParent<
    ImportMachine,
    Parameters = {
      /**
       * filter query
       */
      @query("filter")
      filter?: string;

      /**
       * page size  query
       */
      @query("top")
      top?: string;

      /**
       * Optional parameter for continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Total count of machines in the given site.
       */
      @query("totalRecordCount")
      totalRecordCount?: int32;
    }
  >;
}

@@doc(ImportMachine.name, "Machine name");
@@doc(ImportMachine.properties,
  "The resource-specific properties for this resource."
);
