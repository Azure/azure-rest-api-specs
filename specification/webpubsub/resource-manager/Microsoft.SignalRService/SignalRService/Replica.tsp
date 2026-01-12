import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebPubSubResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.SignalRService;
/**
 * A class represent a replica resource.
 */
@parentResource(WebPubSubResource)
model Replica
  is Azure.ResourceManager.TrackedResource<ReplicaProperties, true> {
  ...ResourceNameParameter<
    Resource = Replica,
    KeyName = "replicaName",
    SegmentName = "replicas",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
  >;

  /**
   * The billing information of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;
}

@armResourceOperations
interface Replicas {
  /**
   * Get the replica and its properties.
   */
  get is ArmResourceRead<Replica>;

  /**
   * Create or update a replica.
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Replica>;

  /**
   * Operation to update an exiting replica.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Replica,
    PatchModel = Replica,
    Response = Replica | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Replica>> & {
      @bodyRoot
      _: Replica;
    })
  >;

  /**
   * Operation to delete a replica.
   */
  delete is ArmResourceDeleteSync<Replica>;

  /**
   * List all replicas belong to this resource
   */
  list is ArmResourceListByParent<Replica, Response = ArmResponse<ReplicaList>>;

  /**
   * List all available skus of the replica resource.
   */
  @get
  @action("skus")
  listReplicaSkus is ArmResourceActionSync<Replica, void, ArmResponse<SkuList>>;

  /**
   * Operation to restart a replica.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restart is ArmResourceActionAsync<Replica, void, void>;
}

@@maxLength(Replica.name, 63);
@@minLength(Replica.name, 3);
@@doc(Replica.name, "The name of the replica.");
@@doc(Replica.properties, "");
@@doc(Replicas.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(Replicas.update::parameters.properties,
  "Parameters for the update operation"
);
