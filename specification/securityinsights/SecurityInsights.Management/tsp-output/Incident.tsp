import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;

model Incident is ProxyResource<IncidentProperties> {
  @doc("Incident ID")
  @path
  @key("incidentId")
  @segment("incidents")
  name: string;
}

@armResourceOperations
interface Incidents {
  @doc("Gets an incident.")
  get is ArmResourceRead<Incident>;
  @doc("Creates or updates the incident.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Incident>;
  @doc("Delete the incident.")
  delete is ArmResourceDeleteSync<Incident>;
  @doc("Gets all incidents.")
  list is ArmResourceListByParent<
    Incident,
    {
      ...BaseParameters<Incident>;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results. Optional.")
      @query("$orderby")
      $orderby?: string;

      @doc("Returns only the first n results. Optional.")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
  @doc("Triggers playbook on a specific incident")
  runPlaybook is ArmResourceActionNoContentSync<
    Incident,
    ManualTriggerRequestBody,
    {
      ...BaseParameters<Incident>;

      @path
      incidentIdentifier: string;
    }
  >;
  @doc("Creates a Microsoft team to investigate the incident by sharing information and insights between participants.")
  createTeam is ArmResourceActionSync<
    Incident,
    TeamInformation,
    TeamInformation
  >;
  @doc("Gets all incident alerts.")
  listAlerts is ArmResourceActionSync<Incident, {}, IncidentAlertList>;
  @doc("Gets all incident bookmarks.")
  listBookmarks is ArmResourceActionSync<Incident, {}, IncidentBookmarkList>;
  @doc("Gets all incident related entities.")
  listEntities is ArmResourceActionSync<Incident, {}, IncidentEntitiesResponse>;
}
