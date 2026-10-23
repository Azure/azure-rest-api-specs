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
  @tag("ImportMachinesController")
  get is ArmResourceRead<ImportMachine>;

  /**
   * Delete a ImportMachine
   */
  @tag("ImportMachinesController")
  delete is ArmResourceDeleteSync<ImportMachine>;

  /**
   * List ImportMachine resources by ImportSite
   */
  @tag("ImportMachinesController")
  listByImportSite is ArmResourceListByParent<
    ImportMachine,
    Parameters = {
      /**
       * filter query
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByImportSite.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * page size  query
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByImportSite.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: string;

      /**
       * Optional parameter for continuation token.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByImportSite.continuationToken retains the continuationToken query parameter; preserve wire compatibility."
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Total count of machines in the given site.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByImportSite.totalRecordCount retains the totalRecordCount query parameter; preserve wire compatibility."
      @query("totalRecordCount")
      totalRecordCount?: int32;
    }
  >;
}

@@doc(ImportMachine.name, "Machine name");
@@doc(
  ImportMachine.properties,
  "The resource-specific properties for this resource."
);
