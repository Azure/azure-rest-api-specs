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

namespace Microsoft.CognitiveServices;
/**
 * Agent Application resource
 */
@parentResource(Project)
model AgentApplication
  is Azure.ResourceManager.ProxyResource<AgenticApplication, false> {
  ...ResourceNameParameter<
    Resource = AgentApplication,
    KeyName = "name",
    SegmentName = "applications",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AgentApplications {
  /**
   * Gets an Agent Application by name.
   */
  get is ArmResourceRead<AgentApplication>;

  /**
   * Creates or updates an Agent Application (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgentApplication,
    LroHeaders = ArmLroLocationHeader<FinalResult = AgentApplication> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Agent Application.
   */
  delete is ArmResourceDeleteWithoutOkAsync<AgentApplication>;

  /**
   * Lists Agent Applications in the project.
   */
  list is ArmResourceListByParent<
    AgentApplication,
    Parameters = {
      /**
       * Number of agent applications to be retrieved in a page of results.
       */
      @query("count")
      count?: int32 = 30;

      /**
       * Number of agent applications to skip.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Names of agent applications to retrieve.
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
      @query(#{ name: "names", explode: true })
      names?: string[];

      /**
       * Search text for filtering agent applications.
       */
      @query("searchText")
      searchText?: string;

      /**
       * Field to order by.
       */
      @query("orderBy")
      orderBy?: string;

      /**
       * Whether to order in ascending order.
       */
      @query("orderByAsc")
      orderByAsc?: boolean;
    },
    Response = ArmResponse<AgentApplicationResourceArmPaginatedResult>
  >;

  /**
   * Lists agents for an Agent Application.
   */
  listAgents is ArmResourceActionSync<
    AgentApplication,
    void,
    ArmResponse<AgentReferenceResourceArmPaginatedResult>
  >;

  /**
   * Enables an Agent Application.
   */
  enable is ArmResourceActionSync<AgentApplication, void, OkResponse>;

  /**
   * Disables an Agent Application.
   */
  disable is ArmResourceActionSync<AgentApplication, void, OkResponse>;
}

@@doc(AgentApplication.name, "Name for the Agent Application.");
@@doc(AgentApplication.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(AgentApplications.createOrUpdate::parameters.resource,
  "Agent Application definition object."
);
