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

alias AgentApplicationsListParameters = {
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
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  orderByAsc?: boolean = false;
};

/**
 * Agent Application resource
 */
@parentResource(Project)
model AgentApplication
  is Azure.ResourceManager.ProxyResource<AgenticApplicationProperties, false> {
  ...ResourceNameParameter<
    Resource = AgentApplication,
    KeyName = "name",
    SegmentName = "applications",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface AgentApplications {
  /**
   * Gets an Agent Application by name.
   */
  @tag("AgentApplication")
  get is ArmResourceRead<
    AgentApplication,
    Response = ArmResponse<AgentApplication>
  >;

  /**
   * Creates or updates an Agent Application (asynchronous).
   */
  @tag("AgentApplication")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgentApplication,
    Response = ArmResponse<AgentApplication> | ArmResourceCreatedResponse<
      AgentApplication,
      LroHeaders = ArmLroLocationHeader<FinalResult = AgentApplication> & {
        /**
         * URI to poll for asynchronous operation status.
         */
        @header("Azure-AsyncOperation")
        azureAsyncOperation: string;

        /**
         * Timeout for the client to use when polling the asynchronous operation.
         */
        #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @header("x-ms-async-operation-timeout")
        @format("duration")
        asyncOperationTimeout: string;
      }
    >
  >;

  /**
   * Delete Agent Application.
   */
  @tag("AgentApplication")
  delete is ArmResourceDeleteWithoutOkAsync<AgentApplication>;

  /**
   * Lists Agent Applications in the project.
   */
  @tag("AgentApplication")
  list is ArmResourceListByParent<
    AgentApplication,
    Parameters = AgentApplicationsListParameters,
    Response = ArmResponse<AgentApplicationResourceArmPaginatedResult>
  >;

  /**
   * Lists agents for an Agent Application.
   */
  @tag("AgentApplication")
  listAgents is ArmResourceActionSync<
    AgentApplication,
    void,
    ArmResponse<AgentReferenceResourceArmPaginatedResult>
  >;

  /**
   * Enables an Agent Application.
   */
  @tag("AgentApplication")
  enable is ArmResourceActionSync<AgentApplication, void, OkResponse>;

  /**
   * Disables an Agent Application.
   */
  @tag("AgentApplication")
  disable is ArmResourceActionSync<AgentApplication, void, OkResponse>;
}

@@doc(AgentApplication.name, "Name for the Agent Application.");
@@doc(AgentApplication.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(AgentApplications.createOrUpdate::parameters.resource,
  "Agent Application definition object."
);
@@summary(AgentApplications.list, "Lists Agent Applications in the project.");
@@summary(AgentApplications.get, "Gets an Agent Application by name.");
@@summary(AgentApplications.createOrUpdate,
  "Creates or updates an Agent Application (asynchronous)."
);
@@summary(AgentApplications.delete, "Delete Agent Application.");
@@summary(AgentApplications.disable, "Disables an Agent Application.");
@@summary(AgentApplications.enable, "Enables an Agent Application.");
@@summary(AgentApplications.listAgents,
  "Lists agents for an Agent Application."
);
