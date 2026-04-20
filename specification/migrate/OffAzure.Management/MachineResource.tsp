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

@armResourceOperations
interface MachineResources {
  /**
   * Get a MachineResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MachinesController_Get")
  get is ArmResourceRead<MachineResource>;

  /**
   * Update a MachineResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MachinesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    MachineResource,
    PatchModel = MachineResourceUpdate
  >;

  /**
   * List MachineResource resources by VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MachinesController_ListByVmwareSite")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MachinesController_Start")
  start is ArmResourceActionAsync<MachineResource, void, ArmResponse<unknown>>;

  /**
   * Method to stop a machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MachinesController_Stop")
  stop is ArmResourceActionAsync<MachineResource, void, ArmResponse<unknown>>;
}

@@doc(MachineResource.name, "Machine name");
@@doc(MachineResource.properties,
  "The resource-specific properties for this resource."
);
