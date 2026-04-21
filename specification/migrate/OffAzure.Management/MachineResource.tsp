import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VmwareSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * An machine resource belonging to a site resource.
 */
@parentResource(VmwareSite)
model MachineResource
  is Azure.ResourceManager.ProxyResource<VmwareMachineProperties> {
  ...ResourceNameParameter<
    Resource = MachineResource,
    KeyName = "machineName",
    SegmentName = "machines"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface MachineResources {
  /**
   * Get a MachineResource
   */
  @tag("MachinesController")
  get is ArmResourceRead<MachineResource>;

  /**
   * Update a MachineResource
   */
  @tag("MachinesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    MachineResource,
    PatchModel = MachineResourceUpdate
  >;

  /**
   * List MachineResource resources by VmwareSite
   */
  @tag("MachinesController")
  listByVmwareSite is ArmResourceListByParent<
    MachineResource,
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

  /**
   * Method to start a machine.
   */
  @tag("MachinesController")
  start is ArmResourceActionAsync<
    MachineResource,
    void,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Method to stop a machine.
   */
  @tag("MachinesController")
  stop is ArmResourceActionAsync<
    MachineResource,
    void,
    unknown,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(MachineResource.name, "Machine name");
@@doc(MachineResource.properties,
  "The resource-specific properties for this resource."
);
