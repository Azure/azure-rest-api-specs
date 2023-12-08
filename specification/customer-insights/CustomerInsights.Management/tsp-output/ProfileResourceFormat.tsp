import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Hub.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CustomerInsights;
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
  @doc("Gets information about the specified profile.")
  get is ArmResourceRead<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string;
    }
  >;
  @doc("Creates a profile within a Hub, or updates an existing profile.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProfileResourceFormat>;
  @doc("Deletes a profile within a hub")
  delete is ArmResourceDeleteAsync<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string;
    }
  >;
  @doc("Gets all profile in the hub.")
  listByHub is ArmResourceListByParent<
    ProfileResourceFormat,
    {
      ...BaseParameters<ProfileResourceFormat>;

      @doc("Locale of profile to retrieve, default is en-us.")
      @query("locale-code")
      `locale-code`?: string;
    }
  >;
  @doc("Gets the KPIs that enrich the profile Type identified by the supplied name. Enrichment happens through participants of the Interaction on an Interaction KPI and through Relationships for Profile KPIs.")
  getEnrichingKpis is ArmResourceActionSync<ProfileResourceFormat, {}, {}>;
}
