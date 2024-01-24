import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CustomerInsights;
/**
 * The profile resource format.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Hub)
@Azure.ResourceManager.Private.armResourceInternal(ProfileTypeDefinition)
@includeInapplicableMetadataInPayload(false)
model ProfileResourceFormat extends ProxyResource {
  /**
   * The name of the profile.
   */
  @path
  @key("profileName")
  @segment("profiles")
  name: string;

  /**
   * The profile type definition.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProfileTypeDefinition;
}

@armResourceOperations
interface ProfileResourceFormats {
  /**
   * Gets information about the specified profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Profiles_Get")
  get is ArmResourceRead<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      /**
       * Locale of profile to retrieve, default is en-us.
       */
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  /**
   * Creates a profile within a Hub, or updates an existing profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Profiles_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProfileResourceFormat>;

  /**
   * Deletes a profile within a hub
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Profiles_Delete")
  delete is ArmResourceDeleteAsync<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      /**
       * Locale of profile to retrieve, default is en-us.
       */
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  /**
   * Gets all profile in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Profiles_ListByHub")
  listByHub is ArmResourceListByParent<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      /**
       * Locale of profile to retrieve, default is en-us.
       */
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  /**
   * Gets the KPIs that enrich the profile Type identified by the supplied name. Enrichment happens through participants of the Interaction on an Interaction KPI and through Relationships for Profile KPIs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Profiles_GetEnrichingKpis")
  getEnrichingKpis is ArmResourceActionSync<ProfileResourceFormat, void, void>;
}

@@projectedName(ProfileResourceFormats.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ProfileResourceFormats.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ProfileResourceFormats.createOrUpdate::parameters.resource,
  "Parameters supplied to the create/delete Profile type operation"
);
