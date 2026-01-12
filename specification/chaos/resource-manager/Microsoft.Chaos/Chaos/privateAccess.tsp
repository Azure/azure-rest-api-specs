import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./privateAccess.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@armResourceOperations
@removed(Microsoft.Chaos.Versions.v2025_01_01)
interface PrivateAccesses {
  /**
   * Get a private access resource
   */
  get is ArmResourceRead<PrivateAccess>;

  /**
   * Create or update a private access
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateAccess>;

  /**
   * Patch a private access tags
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<PrivateAccess, PrivateAccessPatch>;

  /**
   * Delete a private access
   */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateAccess>;

  /**
   * Get a list of private access resources in a resource group.
   */
  list is ArmResourceListByParent<
    PrivateAccess,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = PrivateAccessListResult
  >;

  /**
   * Get a list of private access resources in a subscription.
   */
  listAll is ArmListBySubscription<
    PrivateAccess,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = PrivateAccessListResult
  >;

  /**
   * Gets the private link resources possible under private access resource
   */
  @get
  @list
  privateLinkResources is ArmResourceActionSync<
    PrivateAccess,
    void,
    PrivateLinkResourceListResult
  >;
}

@@minLength(PrivateAccess.name, 1);
@@doc(PrivateAccess.name,
  "The name of the private access resource that is being created. Supported characters for the name are a-z, A-Z, 0-9, _ and -. The maximum name length is 80 characters."
);
@@doc(PrivateAccess.properties,
  "The resource-specific properties for this resource."
);
@@doc(PrivateAccesses.createOrUpdate::parameters.resource,
  "private access resource to be created or updated."
);
@@doc(PrivateAccesses.update::parameters.properties,
  "private access resource's tags to be updated."
);
