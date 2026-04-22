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
        ...ApiVersionParameter;
        ...SubscriptionIdParameter;
        ...ResourceGroupParameter;
        ...Azure.ResourceManager.Legacy.Provider;

        /** Name of the App Service plan. */
        @path
        @segment("serverfarms")
        @key
        name: string;
      },
      {
        /** Name of the silo. */
        @path
        @segment("silos")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$")
        siloName: string;
      }
    > {}

@added(Versions.v2026_06_01_preview)
@tag("AppServicePlans")
@armResourceOperations(#{ omitTags: true })
interface ServerFarmSilos {
  /**
   * Get a specific silo for an App Service plan.
   */
  @summary("Get a specific silo for an App Service plan.")
  getServerFarmSilo is ServerFarmSiloOps.Read<
    ServerFarmSilo,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Create or update an App Service plan silo.
   */
  @summary("Create or update an App Service plan silo.")
  createOrUpdateServerFarmSilo is ServerFarmSiloOps.CreateOrUpdateAsync<
    ServerFarmSilo,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Delete an App Service plan silo.
   */
  @summary("Delete an App Service plan silo.")
  deleteServerFarmSilo is ServerFarmSiloOps.DeleteWithoutOkAsync<
    ServerFarmSilo,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Get all silos for an App Service plan.
   */
  @summary("Get all silos for an App Service plan.")
  listServerFarmSilos is ServerFarmSiloOps.List<
    ServerFarmSilo,
    Response = ArmResponse<ServerFarmSiloCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ServerFarmSilo.name, "Name of the silo.");
@@doc(ServerFarmSilo.properties,
  "ServerFarmSilo resource specific properties"
);
@@doc(ServerFarmSilos.createOrUpdateServerFarmSilo::parameters.resource,
  "Details of the silo."
);
