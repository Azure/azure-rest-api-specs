import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebPubSubResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * A class represent a replica resource.
 */
@parentResource(WebPubSubResource)
@Azure.ResourceManager.Private.armResourceInternal(ReplicaProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model Replica extends Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = Replica,
    KeyName = "replicaName",
    SegmentName = "replicas",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
  >;

  /**
   * The billing information of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ResourceSku;

  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.conditionalClientFlatten
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: ReplicaProperties;
}

@armResourceOperations
interface Replicas {
  /**
   * Get the replica and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubReplicas_Get")
  get is ArmResourceRead<Replica>;

  /**
   * Create or update a replica.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubReplicas_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Replica>;

  /**
   * Operation to update an exiting replica.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("WebPubSubReplicas_Update")
  update is ArmCustomPatchAsync<Replica, PatchModel = Replica>;

  /**
   * Operation to delete a replica.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubReplicas_Delete")
  delete is ArmResourceDeleteSync<Replica>;

  /**
   * List all replicas belong to this resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSubReplicas_List")
  list is ArmResourceListByParent<Replica, Response = ArmResponse<ReplicaList>>;

  /**
   * List all available skus of the replica resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("skus")
  @operationId("WebPubSub_ListReplicaSkus")
  listReplicaSkus is ArmResourceActionSync<Replica, void, ArmResponse<SkuList>>;

  /**
   * Operation to restart a replica.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API design"
  @operationId("WebPubSubReplicas_Restart")
  restart is ArmResourceActionAsync<Replica, void, NoContentResponse>;
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
