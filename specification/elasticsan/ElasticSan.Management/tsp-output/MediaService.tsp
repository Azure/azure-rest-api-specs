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
@doc("A Media Services account.")
model MediaService is TrackedResource<MediaServiceProperties> {
  @doc("The Media Services account name.")
  @path
  @key("accountName")
  @segment("mediaservices")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface MediaServices {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the details of a Media Services account")
  @operationId("Mediaservices_Get")
  get is ArmResourceRead<MediaService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a Media Services account")
  @operationId("Mediaservices_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MediaService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing Media Services account")
  @operationId("Mediaservices_Update")
  update is ArmCustomPatchAsync<MediaService, MediaServiceUpdate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a Media Services account")
  @operationId("Mediaservices_Delete")
  delete is ArmResourceDeleteSync<MediaService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List Media Services accounts in the resource group")
  @operationId("Mediaservices_List")
  list is ArmResourceListByParent<MediaService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List Media Services accounts in the subscription.")
  @operationId("Mediaservices_ListBySubscription")
  listBySubscription is ArmListBySubscription<MediaService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Synchronizes storage account keys for a storage account associated with the Media Service account.")
  @operationId("Mediaservices_SyncStorageKeys")
  syncStorageKeys is ArmResourceActionSync<
    MediaService,
    SyncStorageKeysInput,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all the media edge policies associated with the Media Services account.")
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
