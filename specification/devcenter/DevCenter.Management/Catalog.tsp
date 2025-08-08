import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a catalog.
 */
@parentResource(Project)
model Catalog is Azure.ResourceManager.ProxyResource<CatalogProperties> {
  ...ResourceNameParameter<
    Resource = Catalog,
    KeyName = "catalogName",
    SegmentName = "catalogs",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface CatalogOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the project. */
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        projectName: string,
      },
      {
        /** The name of the Catalog. */
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      }
    > {}

@armResourceOperations
interface Catalogs {
  /**
   * Gets an associated project catalog.
   */
  get is CatalogOps.Read<Catalog>;

  /**
   * Creates or updates a project catalog.
   */
  createOrUpdate is CatalogOps.CreateOrUpdateAsync<Catalog>;

  /**
   * Partially updates a project catalog.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  patch is CatalogOps.CustomPatchAsync<
    Catalog,
    PatchModel = CatalogUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = Catalog | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmAsyncOperationHeader<FinalResult = Catalog>
    >
  >;

  /**
   * Deletes a project catalog resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is CatalogOps.DeleteWithoutOkAsync<
    Catalog,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the catalogs associated with a project.
   */
  list is CatalogOps.List<
    Catalog,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    Response = CatalogListResult
  >;

  /**
   * Gets project catalog synchronization error details
   */
  getSyncErrorDetails is CatalogOps.ActionSync<
    Catalog,
    void,
    ArmResponse<SyncErrorDetails>
  >;

  /**
   * Syncs templates for a template source.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sync is CatalogOps.ActionAsync<
    Catalog,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Connects a project catalog to enable syncing.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connect is CatalogOps.ActionAsync<
    Catalog,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
}
@armResourceOperations
interface CatalogOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the devcenter. */
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,
      },
      {
        /** The name of the Catalog. */
        @path
        @segment("catalogs")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        catalogName: string,
      }
    > {}

@armResourceOperations
interface CatalogOperationGroup {
  /**
   * Gets a catalog
   */
  get is CatalogOperationGroupOps.Read<Catalog>;

  /**
   * Creates or updates a catalog.
   */
  createOrUpdate is CatalogOperationGroupOps.CreateOrUpdateAsync<Catalog>;

  /**
   * Partially updates a catalog.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is CatalogOperationGroupOps.CustomPatchAsync<
    Catalog,
    PatchModel = CatalogUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = Catalog | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmAsyncOperationHeader<FinalResult = Catalog>
    >
  >;

  /**
   * Deletes a catalog resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is CatalogOperationGroupOps.DeleteWithoutOkAsync<
    Catalog,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists catalogs for a devcenter.
   */
  listByDevCenter is CatalogOperationGroupOps.List<
    Catalog,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    Response = CatalogListResult
  >;

  /**
   * Gets catalog synchronization error details
   */
  getSyncErrorDetails is CatalogOperationGroupOps.ActionSync<
    Catalog,
    void,
    ArmResponse<SyncErrorDetails>
  >;

  /**
   * Syncs templates for a template source.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sync is CatalogOperationGroupOps.ActionAsync<
    Catalog,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Connects a catalog to enable syncing.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  connect is CatalogOperationGroupOps.ActionAsync<
    Catalog,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@maxLength(Catalog.name, 63);
@@minLength(Catalog.name, 3);
@@doc(Catalog.name, "The name of the Catalog.");
@@doc(Catalog.properties, "Catalog properties.");
@@doc(Catalogs.createOrUpdate::parameters.resource, "Represents a catalog.");
@@doc(Catalogs.patch::parameters.properties,
  "Updatable project catalog properties."
);
@@doc(CatalogOperationGroup.createOrUpdate::parameters.resource,
  "Represents a catalog."
);
@@doc(CatalogOperationGroup.update::parameters.properties,
  "Updatable catalog properties."
);
