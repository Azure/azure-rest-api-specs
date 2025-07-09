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
model SignalRResource
  is Azure.ResourceManager.TrackedResource<SignalRProperties> {
  ...ResourceNameParameter<
    Resource = SignalRResource,
    KeyName = "resourceName",
    SegmentName = "signalR",
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
interface SignalRResources {
  /**
   * Get the resource and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SignalR_Get")
  get is ArmResourceRead<SignalRResource>;

  /**
   * Create or update a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SignalR_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SignalRResource,
    Response = ArmResourceUpdatedResponse<SignalRResource> | ArmResourceCreatedResponse<SignalRResource> | ArmAcceptedLroResponse
  >;

  /**
   * Operation to update an exiting resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("SignalR_Update")
  update is ArmCustomPatchAsync<SignalRResource, PatchModel = SignalRResource>;

  /**
   * Operation to delete a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("SignalR_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SignalRResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SignalR_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    SignalRResource,
    Response = ArmResponse<SignalRResourceList>
  >;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SignalR_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    SignalRResource,
    Response = ArmResponse<SignalRResourceList>
  >;

  /**
   * Get the access keys of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SignalR_ListKeys")
  listKeys is ArmResourceActionSync<
    SignalRResource,
    void,
    ArmResponse<SignalRKeys>
  >;

  /**
   * Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SignalR_RegenerateKey")
  regenerateKey is ArmResourceActionAsync<
    SignalRResource,
    RegenerateKeyParameters,
    ArmResponse<SignalRKeys>
  >;

  /**
   * Operation to restart a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SignalR_Restart")
  restart is ArmResourceActionAsync<SignalRResource, void, void>;

  /**
   * List all available skus of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("skus")
  @operationId("SignalR_ListSkus")
  listSkus is ArmResourceActionSync<
    SignalRResource,
    void,
    ArmResponse<SkuList>
  >;

  /**
   * Get the private link resources that need to be created for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("SignalRPrivateLinkResources_List")
  list is ArmResourceActionSync<
    SignalRResource,
    void,
    ArmResponse<PrivateLinkResourceList>
  >;
}

@@maxLength(SignalRResource.name, 63);
@@minLength(SignalRResource.name, 3);
@@doc(SignalRResource.name, "The name of the resource.");
@@doc(SignalRResource.properties,
  "A class that describes the properties of the resource"
);
@@doc(SignalRResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(SignalRResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(SignalRResources.regenerateKey::parameters.body,
  "Parameter that describes the Regenerate Key Operation."
);
