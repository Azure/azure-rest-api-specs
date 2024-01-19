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
@doc("The profile resource format.")
@parentResource(Hub)
model ProfileResourceFormat is ProxyResource<ProfileTypeDefinition> {
  @doc("The name of the profile.")
  @path
  @key("profileName")
  @segment("profiles")
  name: string;
}

@armResourceOperations
interface ProfileResourceFormats {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about the specified profile.")
  @operationId("Profiles_Get")
  get is ArmResourceRead<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a profile within a Hub, or updates an existing profile.")
  @operationId("Profiles_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProfileResourceFormat>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a profile within a hub")
  @operationId("Profiles_Delete")
  delete is ArmResourceDeleteAsync<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all profile in the hub.")
  @operationId("Profiles_ListByHub")
  listByHub is ArmResourceListByParent<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string = "en-us";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the KPIs that enrich the profile Type identified by the supplied name. Enrichment happens through participants of the Interaction on an Interaction KPI and through Relationships for Profile KPIs.")
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
