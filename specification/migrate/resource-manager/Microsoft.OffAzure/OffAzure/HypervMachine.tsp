import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HypervSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A machine resource belonging to a site resource.
 */
@parentResource(HypervSite)
model HypervMachine
  is Azure.ResourceManager.ProxyResource<HypervMachineProperties> {
  ...ResourceNameParameter<
    Resource = HypervMachine,
    KeyName = "machineName",
    SegmentName = "machines"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface HypervMachines {
  /**
   * Get a HypervMachine
   */
  @tag("HypervMachinesController")
  get is ArmResourceRead<HypervMachine>;

  /**
   * Update a HypervMachine
   */
  @tag("HypervMachinesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<HypervMachine, PatchModel = HypervMachineUpdate>;

  /**
   * List HypervMachine resources by HypervSite
   */
  @tag("HypervMachinesController")
  listByHypervSite is ArmResourceListByParent<
    HypervMachine,
    Parameters = {
      /**
       * filter query
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByHypervSite.filter retains the filter query parameter; preserve wire compatibility."
      @query("filter")
      filter?: string;

      /**
       * page size  query
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByHypervSite.top retains the top query parameter; preserve wire compatibility."
      @query("top")
      top?: int32;

      /**
       * Optional parameter for continuation token.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByHypervSite.continuationToken retains the continuationToken query parameter; preserve wire compatibility."
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Total count of machines in the given site.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing listByHypervSite.totalRecordCount retains the totalRecordCount query parameter; preserve wire compatibility."
      @query("totalRecordCount")
      totalRecordCount?: int32;
    }
  >;
}

@@doc(HypervMachine.name, " HypervMachine name");
@@doc(
  HypervMachine.properties,
  "The resource-specific properties for this resource."
);
