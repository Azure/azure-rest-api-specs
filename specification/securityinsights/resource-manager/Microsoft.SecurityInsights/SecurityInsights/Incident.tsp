import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

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

// Added manually only to fix KeyName difference from Incident resource, A.K.A. incidentId vs incidentIdentifier
alias IncidentOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.OperationalInsights";

    /**
     * The name of the workspace.
     */
    @segment("workspaces")
    @key
    @path
    @minLength(1)
    @maxLength(90)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Incident>;
  },
  {
    ...Extension.ExtensionProviderNamespace<Incident>;

    /**
     * The incident identifier.
     */
    @path
    @key
    @segment("incidents")
    incidentIdentifier: string;
  }
>;

@armResourceOperations
interface Incidents {
  /**
   * Gets a given incident.
   */
  get is Extension.Read<OperationalInsights, Incident, Error = CloudError>;

  /**
   * Creates or updates an incident.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    Incident,
    Error = CloudError
  >;

  /**
   * Deletes a given incident.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    Incident,
    Error = CloudError
  >;

  /**
   * Gets all incidents.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
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
    Response = ArmResponse<IncidentList>,
    Error = CloudError
  >;

  /**
   * Triggers playbook on a specific incident
   */
  runPlaybook is IncidentOps.ActionSync<
    Incident,
    Request = ManualTriggerRequestBody,
    Response = NoContentResponse,
    ErrorType = CloudError,
    OptionalRequestBody = true
  >;

  /**
   * Gets all alerts for an incident.
   */
  @list
  @action("alerts")
  listAlerts is Extension.ActionSync<
    OperationalInsights,
    Incident,
    void,
    ArmResponse<IncidentAlertList>,
    Error = CloudError
  >;

  /**
   * Gets all bookmarks for an incident.
   */
  @list
  @action("bookmarks")
  listBookmarks is Extension.ActionSync<
    OperationalInsights,
    Incident,
    void,
    ArmResponse<IncidentBookmarkList>,
    Error = CloudError
  >;

  /**
   * Gets all entities for an incident.
   */
  @action("entities")
  listEntities is Extension.ActionSync<
    OperationalInsights,
    Incident,
    void,
    ArmResponse<IncidentEntitiesResponse>,
    Error = CloudError
  >;
}

@@doc(Incident.name, "Incident ID");
@@doc(Incident.properties, "Incident properties");
@@doc(Incidents.createOrUpdate::parameters.resource, "The incident");
@@doc(Incidents.runPlaybook::parameters.body,
  "Describes the request body for triggering a playbook on an incident."
);
