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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(WebPubSubProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model WebPubSubResource extends Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = WebPubSubResource,
    KeyName = "resourceName",
    SegmentName = "webPubSub",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$"
  >;

  /**
   * The billing information of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ResourceSku;

  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: WebPubSubProperties;

  /**
   * The kind of the service
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind?: ServiceKind;

  /**
   * A class represent managed identities used for request and response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: ManagedIdentity;
}

@armResourceOperations
interface WebPubSubResources {
  /**
   * Get the resource and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSub_Get")
  get is ArmResourceRead<WebPubSubResource>;

  /**
   * Create or update a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSub_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WebPubSubResource,
    Response = ArmResponse<WebPubSubResource> | ArmResourceCreatedResponse<
      WebPubSubResource,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = WebPubSubResource>
    > | {
      @statusCode statusCode: 202;
    }
  >;

  /**
   * Operation to update an exiting resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @operationId("WebPubSub_Update")
  update is ArmCustomPatchAsync<
    WebPubSubResource,
    PatchModel = WebPubSubResource
  >;

  /**
   * Operation to delete a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSub_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    WebPubSubResource,
    Response =
      | OkResponse
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSub_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    WebPubSubResource,
    Response = ArmResponse<WebPubSubResourceList>
  >;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSub_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    WebPubSubResource,
    Response = ArmResponse<WebPubSubResourceList>
  >;

  /**
   * Get the access keys of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSub_ListKeys")
  listKeys is ArmResourceActionSync<WebPubSubResource, void, WebPubSubKeys>;

  /**
   * Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSub_RegenerateKey")
  regenerateKey is ArmResourceActionSync<
    WebPubSubResource,
    RegenerateKeyParameters,
    Response = WebPubSubKeys | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: WebPubSubKeys;
    })
  >;

  /**
   * Operation to restart a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("WebPubSub_Restart")
  restart is ArmResourceActionAsync<WebPubSubResource, void, void>;

  /**
   * List all available skus of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
