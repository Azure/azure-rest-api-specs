import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Common;

namespace Compute;
/**
 * Specifies information about the Interconnect Block.
 */
@added(Versions.v2026_03_01)
model InterconnectBlock
  is Azure.ResourceManager.TrackedResource<InterconnectBlockProperties> {
  ...ResourceNameParameter<
    Resource = InterconnectBlock,
    KeyName = "interconnectBlockName",
    SegmentName = "interconnectBlocks",
    NamePattern = ""
  >;

  /**
   * SKU of the resource for which capacity needs to be pre-allocated. Both `sku.name` and `sku.capacity` are required at create. After create, only `sku.capacity` can be updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: Sku;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * Placement section specifies the user-defined constraints for Interconnect Block hardware placement. This property cannot be changed once Interconnect Block is provisioned.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  placement?: Placement;
}

@added(Versions.v2026_03_01)
@armResourceOperations
interface InterconnectBlocks {
  /**
   * Retrieves information about an Interconnect Block.
   */
  get is ComputeResourceRead<
    InterconnectBlock,
    Parameters = {
      /**
       * The expand expression to apply on the operation. 'instanceView' retrieves a snapshot of the runtime properties of the Interconnect Block that is managed by the platform and can change outside of control plane operations.
       */
      @query("$expand")
      $expand?: InterconnectBlockExpandTypes;
    }
  >;

  /**
   * Creates or updates an Interconnect Block. When updating an Interconnect Block, only tags and sku.capacity may be modified.
   */
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    InterconnectBlock,
    LroHeaders = ArmLroLocationHeader<FinalResult = InterconnectBlock> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an Interconnect Block. When updating an Interconnect Block, only tags and sku.capacity may be modified.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchAsync<
    InterconnectBlock,
    InterconnectBlockUpdate,
    LroHeaders = ArmLroLocationHeader<FinalResult = InterconnectBlock> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an Interconnect Block. The operation is only allowed when there are no virtual machines or VMSS VM instances associated with the Interconnect Block.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ComputeResourceDeleteAsync<
    InterconnectBlock,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all of the Interconnect Blocks in the specified resource group. Use the nextLink property in the response to get the next page of Interconnect Blocks.
   */
  listByResourceGroup is ComputeResourceListByParent<
    InterconnectBlock,
    Response = InterconnectBlockListResult
  >;

  /**
   * Lists all of the Interconnect Blocks in the subscription. Use the nextLink property in the response to get the next page of Interconnect Blocks.
   */
  listBySubscription is ComputeListBySubscription<
    InterconnectBlock,
    Response = InterconnectBlockListResult
  >;
}

@@doc(InterconnectBlock.name, "The name of the Interconnect Block.");
@@doc(InterconnectBlock.properties, "Properties of the Interconnect Block.");
@@doc(InterconnectBlocks.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Interconnect Block."
);
@@doc(InterconnectBlocks.update::parameters.properties,
  "Parameters supplied to the Update Interconnect Block operation."
);
