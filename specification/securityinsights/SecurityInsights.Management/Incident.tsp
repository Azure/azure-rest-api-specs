import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents an incident in Azure Security Insights.
 */
model Incident is Azure.ResourceManager.ProxyResource<IncidentProperties> {
  ...ResourceNameParameter<
    Resource = Incident,
    KeyName = "incidentId",
    SegmentName = "incidents",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias IncidentWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface Incidents {
  /**
   * Gets a given incident.
   */
  get is ArmResourceRead<Incident>;

  /**
   * Creates or updates an incident.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Incident>;

  /**
   * Deletes a given incident.
   */
  delete is ArmResourceDeleteSync<Incident>;

  /**
   * Gets all incidents.
   */
  list is ArmResourceListByParent<
    Incident,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @maxValue(1000)
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<IncidentList>
  >;

  /**
   * Triggers playbook on a specific incident
   */
  runPlaybook is ArmResourceActionSync<
    Incident,
    ManualTriggerRequestBody,
    NoContentResponse,
    Parameters = {
      /**
       * Incident ID
       */
      @path
      incidentIdentifier: string;
    },
    OptionalRequestBody = true
  >;

  /**
   * Gets all alerts for an incident.
   */
  @list
  @action("alerts")
  listAlerts is ArmResourceActionSync<
    Incident,
    void,
    ArmResponse<IncidentAlertList>
  >;

  /**
   * Gets all bookmarks for an incident.
   */
  @list
  @action("bookmarks")
  listBookmarks is ArmResourceActionSync<
    Incident,
    void,
    ArmResponse<IncidentBookmarkList>
  >;

  /**
   * Gets all entities for an incident.
   */
  @action("entities")
  listEntities is ArmResourceActionSync<
    Incident,
    void,
    ArmResponse<IncidentEntitiesResponse>
  >;
}

@@doc(Incident.name, "Incident ID");
@@doc(Incident.properties, "Incident properties");
@@doc(Incidents.createOrUpdate::parameters.resource, "The incident");
@@doc(Incidents.runPlaybook::parameters.body,
  "Describes the request body for triggering a playbook on an incident."
);
