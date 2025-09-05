import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NotificationHubs;
/**
 * Notification Hubs Namespace Resource.
 */
model NamespaceResource
  is Azure.ResourceManager.TrackedResource<NamespaceProperties, true> {
  ...ResourceNameParameter<
    Resource = NamespaceResource,
    KeyName = "namespaceName",
    SegmentName = "namespaces",
    NamePattern = "^[a-zA-Z][a-zA-Z0-9-]*$"
  >;

  /**
   * The Sku description for a namespace
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;
}

@armResourceOperations
interface NamespaceResources {
  /**
   * Returns the given namespace.
   */
  get is ArmResourceRead<NamespaceResource>;

  /**
   * Creates / Updates a Notification Hub namespace. This operation is idempotent.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NamespaceResource>;

  /**
   * Patches the existing namespace.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NamespaceResource,
    PatchModel = NamespacePatchParameters
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated notificationHubs under the namespace.
   */
  delete is ArmResourceDeleteSync<NamespaceResource>;

  /**
   * Lists the available namespaces within a resource group.
   */
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
  checkNotificationHubAvailability is ArmResourceActionSync<
    NamespaceResource,
    CheckAvailabilityParameters,
    ArmResponse<CheckAvailabilityResult>
  >;

  /**
   * Lists the PNS credentials associated with a namespace.
   */
  @action("pnsCredentials")
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
