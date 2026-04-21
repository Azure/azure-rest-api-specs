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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("HypervMachinesController")
  @operationId("HypervMachinesController_Get")
  get is ArmResourceRead<HypervMachine>;

  /**
   * Update a HypervMachine
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("HypervMachinesController")
  @operationId("HypervMachinesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<HypervMachine, PatchModel = HypervMachineUpdate>;

  /**
   * List HypervMachine resources by HypervSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("HypervMachinesController")
  @operationId("HypervMachinesController_ListByHypervSite")
  listByHypervSite is ArmResourceListByParent<
    HypervMachine,
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
      top?: int32;

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

@@doc(HypervMachine.name, " HypervMachine name");
@@doc(HypervMachine.properties,
  "The resource-specific properties for this resource."
);
