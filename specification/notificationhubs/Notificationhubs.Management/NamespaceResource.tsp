import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NotificationHubs;
/**
 * Notification Hubs Namespace Resource.
 */
@Azure.ResourceManager.Private.armResourceInternal(NamespaceProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NamespaceResource extends Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = NamespaceResource,
    KeyName = "namespaceName",
    SegmentName = "namespaces",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]*$"
  >;

  /**
   * The Sku description for a namespace
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: Sku;

  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.conditionalClientFlatten
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: NamespaceProperties;
}

@armResourceOperations
interface NamespaceResources {
  /**
   * Returns the given namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_Get")
  get is ArmResourceRead<NamespaceResource>;

  /**
   * Creates / Updates a Notification Hub namespace. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NamespaceResource>;

  /**
   * Patches the existing namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Namespaces_Update")
  update is ArmCustomPatchSync<
    NamespaceResource,
    PatchModel = NamespacePatchParameters
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated notificationHubs under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteSync<NamespaceResource>;

  /**
   * Lists the available namespaces within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_List")
  list is ArmResourceListByParent<
    NamespaceResource,
    Parameters = {
      /**
       * Skip token for subsequent requests.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Maximum number of results to return.
       */
      @query("$top")
      $top?: int32 = 100;
    },
    Response = NamespaceListResult
  >;

  /**
   * Lists all the available namespaces within the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_ListAll")
  listAll is ArmListBySubscription<
    NamespaceResource,
    Parameters = {
      /**
       * Skip token for subsequent requests.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Maximum number of results to return.
       */
      @query("$top")
      $top?: int32 = 100;
    },
    Response = NamespaceListResult
  >;

  /**
   * Checks the availability of the given notificationHub in a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NotificationHubs_CheckNotificationHubAvailability")
  checkNotificationHubAvailability is ArmResourceActionSync<
    NamespaceResource,
    CheckAvailabilityParameters,
    ArmResponse<CheckAvailabilityResult>
  >;

  /**
   * Lists the PNS credentials associated with a namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("pnsCredentials")
  @operationId("Namespaces_GetPnsCredentials")
  getPnsCredentials is ArmResourceActionSync<
    NamespaceResource,
    void,
    ArmResponse<PnsCredentialsResource>
  >;
}

@@maxLength(NamespaceResource.name, 50);
@@minLength(NamespaceResource.name, 1);
@@doc(NamespaceResource.name, "Namespace name");
@@doc(NamespaceResource.properties, "Represents namespace properties.");
@@doc(NamespaceResources.createOrUpdate::parameters.resource,
  "Request content."
);
@@doc(NamespaceResources.update::parameters.properties, "Request content.");
@@doc(NamespaceResources.checkNotificationHubAvailability::parameters.body,
  "Request content."
);
