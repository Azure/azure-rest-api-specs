import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SignalRService;
/**
 * A class represent a resource.
 */
model WebPubSubResource
  is Azure.ResourceManager.TrackedResource<WebPubSubProperties> {
  ...ResourceNameParameter<
    Resource = WebPubSubResource,
    KeyName = "resourceName",
    SegmentName = "webPubSub",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
  >;

  /**
   * The billing information of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ResourceSku;

  /**
   * The kind of the service
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind?: ServiceKind;

  /**
   * A class represent managed identities used for request and response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedIdentity;
}

@armResourceOperations
interface WebPubSubResources {
  /**
   * Get the resource and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSub_Get")
  get is ArmResourceRead<WebPubSubResource>;

  /**
   * Create or update a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebPubSub_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WebPubSubResource,
    Response = ArmResourceUpdatedResponse<WebPubSubResource> | ArmResourceCreatedResponse<WebPubSubResource> | ArmAcceptedLroResponse
  >;

  /**
   * Operation to update an exiting resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("WebPubSub_Update")
  update is ArmCustomPatchAsync<
    WebPubSubResource,
    PatchModel = WebPubSubResource
  >;

  /**
   * Operation to delete a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebPubSub_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    WebPubSubResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSub_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    WebPubSubResource,
    Response = ArmResponse<WebPubSubResourceList>
  >;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSub_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    WebPubSubResource,
    Response = ArmResponse<WebPubSubResourceList>
  >;

  /**
   * Get the access keys of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSub_ListKeys")
  listKeys is ArmResourceActionSync<
    WebPubSubResource,
    void,
    ArmResponse<WebPubSubKeys>
  >;

  /**
   * Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSub_RegenerateKey")
  regenerateKey is ArmResourceActionAsync<
    WebPubSubResource,
    RegenerateKeyParameters,
    ArmResponse<WebPubSubKeys>
  >;

  /**
   * Operation to restart a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebPubSub_Restart")
  restart is ArmResourceActionAsync<WebPubSubResource, void, NoContentResponse>;

  /**
   * List all available skus of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("skus")
  @operationId("WebPubSub_ListSkus")
  listSkus is ArmResourceActionSync<
    WebPubSubResource,
    void,
    ArmResponse<SkuList>
  >;

  /**
   * Get the private link resources that need to be created for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("WebPubSubPrivateLinkResources_List")
  list is ArmResourceActionSync<
    WebPubSubResource,
    void,
    ArmResponse<PrivateLinkResourceList>
  >;
}

@@maxLength(WebPubSubResource.name, 63);
@@minLength(WebPubSubResource.name, 3);
@@doc(WebPubSubResource.name, "The name of the resource.");
@@doc(WebPubSubResource.properties,
  "A class that describes the properties of the resource"
);
@@doc(WebPubSubResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(WebPubSubResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(WebPubSubResources.regenerateKey::parameters.body,
  "Parameter that describes the Regenerate Key Operation."
);
