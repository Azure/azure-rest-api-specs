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

@doc("Represents a catalog.")
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

        @doc("The name of the project.")
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
        @minLength(3)
        @maxLength(63)
        projectName: string,
      },
      {
        @doc("The name of the Catalog.")
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
  @doc("Gets an associated project catalog.")
  get is CatalogOps.Read<Catalog>;

  @doc("Creates or updates a project catalog.")
  createOrUpdate is CatalogOps.CreateOrUpdateAsync<Catalog>;

  @doc("Partially updates a project catalog.")
  @patch(#{ implicitOptionality: false })
  patch is CatalogOps.CustomPatchAsync<
    Catalog,
    PatchModel = CatalogUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = Catalog | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = Catalog>
    >
  >;

  @doc("Deletes a project catalog resource.")
  delete is CatalogOps.DeleteWithoutOkAsync<
    Catalog,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists the catalogs associated with a project.")
  list is CatalogOps.List<
    Catalog,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = CatalogListResult
  >;

  @doc("Gets project catalog synchronization error details")
  getSyncErrorDetails is CatalogOps.ActionSync<
    Catalog,
    void,
    ArmResponse<SyncErrorDetails>
  >;

  @doc("Syncs templates for a template source.")
  sync is CatalogOps.ActionAsync<
    Catalog,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>
  >;

  @doc("Connects a project catalog to enable syncing.")
  connect is CatalogOps.ActionAsync<
    Catalog,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>
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

        @doc("The name of the devcenter.")
        @path
        @segment("devcenters")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{2,25}$")
        @minLength(3)
        @maxLength(26)
        devCenterName: string,
      },
      {
        @doc("The name of the Catalog.")
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
  @doc("Gets a catalog.")
  get is CatalogOperationGroupOps.Read<Catalog>;

  @doc("Creates or updates a catalog.")
  createOrUpdate is CatalogOperationGroupOps.CreateOrUpdateAsync<Catalog>;

  @doc("Partially updates a catalog.")
  @patch(#{ implicitOptionality: false })
  update is CatalogOperationGroupOps.CustomPatchAsync<
    Catalog,
    PatchModel = CatalogUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = Catalog | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = Catalog>
    >
  >;

  @doc("Deletes a catalog resource.")
  delete is CatalogOperationGroupOps.DeleteWithoutOkAsync<
    Catalog,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists catalogs for a devcenter.")
  listByDevCenter is CatalogOperationGroupOps.List<
    Catalog,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = CatalogListResult
  >;

  @doc("Gets catalog synchronization error details.")
  getSyncErrorDetails is CatalogOperationGroupOps.ActionSync<
    Catalog,
    void,
    ArmResponse<SyncErrorDetails>
  >;

  @doc("Syncs templates for a template source.")
  sync is CatalogOperationGroupOps.ActionAsync<
    Catalog,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>
  >;

  @doc("Connects a catalog to enable syncing.")
  connect is CatalogOperationGroupOps.ActionAsync<
    Catalog,
    void,
    void,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>
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
