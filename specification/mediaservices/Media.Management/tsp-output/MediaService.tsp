import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A Media Services account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(MediaServiceProperties)
model MediaService extends TrackedResourceBase {
  /**
   * The Media Services account name.
   */
  @path
  @key("accountName")
  @segment("mediaservices")
  @visibility("read")
  name: string;

  /**
   * The resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MediaServiceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface MediaServices {
  /**
   * Get the details of a Media Services account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Mediaservices_Get")
  get is ArmResourceRead<MediaService>;

  /**
   * Creates or updates a Media Services account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Mediaservices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MediaService>;

  /**
   * Updates an existing Media Services account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Mediaservices_Update")
  update is ArmCustomPatchAsync<MediaService, MediaServiceUpdate>;

  /**
   * Deletes a Media Services account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Mediaservices_Delete")
  delete is ArmResourceDeleteSync<MediaService>;

  /**
   * List Media Services accounts in the resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Mediaservices_List")
  list is ArmResourceListByParent<MediaService>;

  /**
   * List Media Services accounts in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Mediaservices_ListBySubscription")
  listBySubscription is ArmListBySubscription<MediaService>;

  /**
   * Synchronizes storage account keys for a storage account associated with the Media Service account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Mediaservices_SyncStorageKeys")
  syncStorageKeys is ArmResourceActionSync<
    MediaService,
    SyncStorageKeysInput,
    void
  >;

  /**
   * List all the media edge policies associated with the Media Services account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Mediaservices_ListEdgePolicies")
  listEdgePolicies is ArmResourceActionSync<
    MediaService,
    ListEdgePoliciesInput,
    EdgePolicies
  >;
}

@@projectedName(MediaServices.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(MediaServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(MediaServices.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@projectedName(MediaServices.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(MediaServices.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(MediaServices.update::parameters.properties, "The request parameters");
@@projectedName(MediaServices.syncStorageKeys::parameters.body,
  "json",
  "parameters"
);
@@extension(MediaServices.syncStorageKeys::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(MediaServices.syncStorageKeys::parameters.body, "The request parameters");
@@projectedName(MediaServices.listEdgePolicies::parameters.body,
  "json",
  "parameters"
);
@@extension(MediaServices.listEdgePolicies::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(MediaServices.listEdgePolicies::parameters.body,
  "The request parameters"
);
