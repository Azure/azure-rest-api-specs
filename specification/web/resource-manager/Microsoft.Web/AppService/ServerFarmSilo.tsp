import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./AppServicePlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * Represents a silo of an App Service plan.
 */
@added(Versions.v2026_06_01_preview)
@parentResource(AppServicePlan)
model ServerFarmSilo
  is Azure.ResourceManager.TrackedResource<ServerFarmSiloProperties> {
  ...ResourceNameParameter<
    Resource = ServerFarmSilo,
    KeyName = "siloName",
    SegmentName = "silos",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$"
  >;

  /** Kind of resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing pattern in Microsoft.Web"
  kind?: string;
}

@added(Versions.v2026_06_01_preview)
@armResourceOperations
interface ServerFarmSiloOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the App Service plan. */
        @path
        @segment("serverfarms")
        @key
        name: string,
      },
      {
        /** Name of the silo. */
        @path
        @segment("silos")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$")
        siloName: string,
      }
    > {}

@added(Versions.v2026_06_01_preview)
@tag("AppServicePlans")
@armResourceOperations(#{ omitTags: true })
interface ServerFarmSilos {
  /**
   * Returns the details of a specific silo associated with the specified App Service plan.
   */
  @summary("Get a specific silo for an App Service plan.")
  get is ServerFarmSiloOps.Read<
    ServerFarmSilo,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Creates a new silo or updates an existing silo for the specified App Service plan.
   */
  @summary("Create or update an App Service plan silo.")
  createOrUpdate is ServerFarmSiloOps.CreateOrUpdateAsync<
    ServerFarmSilo
  >;

  /**
   * Updates the tags of an existing App Service plan silo.
   */
  @summary("Update an App Service plan silo.")
  update is ServerFarmSiloOps.CustomPatchSync<
    ServerFarmSilo,
    PatchModel = ServerFarmSiloPatchResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Deletes the specified silo from the App Service plan.
   */
  @summary("Delete an App Service plan silo.")
  delete is ServerFarmSiloOps.DeleteWithoutOkAsync<
    ServerFarmSilo
  >;

  /**
   * Returns a paginated list of all silos associated with the specified App Service plan.
   */
  @summary("Get all silos for an App Service plan.")
  list is ServerFarmSiloOps.List<
    ServerFarmSilo,
    Response = ArmResponse<ServerFarmSiloCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ServerFarmSilo.name, "Name of the silo.");
@@doc(ServerFarmSilo.properties, "ServerFarmSilo resource specific properties");
@@doc(ServerFarmSilos.createOrUpdate::parameters.resource,
  "Details of the silo."
);
@@doc(ServerFarmSilos.update::parameters.properties,
  "Details of the silo update."
);
