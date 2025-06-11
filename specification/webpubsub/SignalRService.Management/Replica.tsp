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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "armResourceInternal is required for ARM resource definition in TypeSpec"
@Azure.ResourceManager.Private.armResourceInternal(ReplicaProperties)
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "includeInapplicableMetadataInPayload is required to maintain compatibility with existing API"
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Replica extends TrackedResource to follow ARM standard resource pattern for backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "conditionalClientFlatten is required for ARM resource client generation"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "armResourcePropertiesOptionality is required for ARM resource definition"
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Properties field documentation is provided by the ReplicaProperties model"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Properties field is required in resource envelope for backward compatibility with existing client SDKs"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Long running operation follows ARM standards with Azure-AsyncOperation header"
  @patch(#{ implicitOptionality: false })
  @operationId("WebPubSubReplicas_Update")
  update is ArmCustomPatchAsync<
    Replica,
    PatchModel = Replica,
    Response = Replica | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Replica>> & {
      @bodyRoot
      _: Replica;
    })
  >;

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
