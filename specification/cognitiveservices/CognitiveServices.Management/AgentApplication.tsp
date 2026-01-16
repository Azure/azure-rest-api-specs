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
model AgentApplicationResource
  is Azure.ResourceManager.ProxyResource<AgenticApplication, false> {
  ...ResourceNameParameter<
    Resource = AgentApplicationResource,
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
  get is ArmResourceRead<
    AgentApplicationResource,
    Response = ArmResponse<AgentApplicationResource>
  >;

  /**
   * Creates or updates an Agent Application (asynchronous).
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgentApplicationResource,
    Response = ArmResponse<AgentApplicationResource> | ArmResourceCreatedResponse<
      AgentApplicationResource,
      LroHeaders = ArmLroLocationHeader<FinalResult = AgentApplicationResource> & {
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
  delete is ArmResourceDeleteWithoutOkAsync<AgentApplicationResource>;

  /**
   * Lists Agent Applications in the project.
   */
  list is ArmResourceListByParent<
    AgentApplicationResource,
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
    },
    Response = ArmResponse<AgentApplicationResourceArmPaginatedResult>
  >;

  /**
   * Lists agents for an Agent Application.
   */
  listAgents is ArmResourceActionSync<
    AgentApplicationResource,
    void,
    ArmResponse<AgentReferenceResourceArmPaginatedResult>
  >;

  /**
   * Enables an Agent Application.
   */
  enable is ArmResourceActionSync<AgentApplicationResource, void, OkResponse>;

  /**
   * Disables an Agent Application.
   */
  disable is ArmResourceActionSync<AgentApplicationResource, void, OkResponse>;
}

@@doc(AgentApplicationResource.name, "Name for the Agent Application.");
@@doc(AgentApplicationResource.properties,
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
