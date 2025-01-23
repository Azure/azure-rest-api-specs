import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fleetspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DatabaseFleetManager;
/**
 * A database fleet manager authorized principal.
 */
@parentResource(Fleetspace)
model AuthorizedPrincipal
  is Azure.ResourceManager.ProxyResource<AuthorizedPrincipalProperties> {
  ...ResourceNameParameter<
    Resource = AuthorizedPrincipal,
    KeyName = "authorizedPrincipalName",
    SegmentName = "authorizedPrincipals",
    NamePattern = "^.+$"
  >;
}

@armResourceOperations
interface AuthorizedPrincipals {
  /**
   * Gets an authorized principal.
   */
  get is ArmResourceRead<AuthorizedPrincipal>;

  /**
   * Creates or updates an authorized principal.
   */
  @removed(Versions.v2025_02_01_preview)
  @sharedRoute
  @renamedFrom(Versions.v2025_02_01_preview, "createOrUpdate")
  createOrUpdateOld is ArmResourceCreateOrReplaceSync<AuthorizedPrincipal>;

  /**
   * Creates or updates an authorized principal.
   */
  @added(Versions.v2025_02_01_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AuthorizedPrincipal>;

  /**
   * Deletes an authorized principal.
   */
  @removed(Versions.v2025_02_01_preview)
  @sharedRoute
  @renamedFrom(Versions.v2025_02_01_preview, "delete")
  deleteOld is ArmResourceDeleteSync<AuthorizedPrincipal>;

  /**
   * Deletes an authorized principal.
   */
  @added(Versions.v2025_02_01_preview)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<AuthorizedPrincipal>;

  /**
   * Gets all authorized principals in a fleet.
   */
  listByFleetspace is ArmResourceListByParent<
    AuthorizedPrincipal,
    Parameters = {
      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int64;

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@doc(AuthorizedPrincipal.name, "Name of the authorized principal.");
@@doc(AuthorizedPrincipal.properties,
  "A database fleet manager authorized principal properties."
);
@@doc(AuthorizedPrincipals.createOrUpdate::parameters.resource,
  "The authorized principal object to create or update."
);
