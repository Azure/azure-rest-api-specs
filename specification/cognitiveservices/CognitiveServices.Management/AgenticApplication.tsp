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

alias AgenticApplicationsListParameters = {
  /**
   * Number of agentic applications to be retrieved in a page of results.
   */
  @query("count")
  count?: int32 = 30;

  /**
   * Number of agentic applications to skip.
   */
  @query("$skip")
  $skip?: int32;

  /**
   * Continuation token for pagination.
   */
  @query("$skipToken")
  $skipToken?: string;

  /**
   * Names of agentic applications to retrieve.
   */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @query(#{ name: "names", explode: true })
  names?: string[];

  /**
   * Search text for filtering agentic applications.
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
 * Agentic Application resource
 */
@parentResource(Project)
model AgenticApplication
  is Azure.ResourceManager.ProxyResource<AgenticApplicationProperties, false> {
  ...ResourceNameParameter<
    Resource = AgenticApplication,
    KeyName = "name",
    SegmentName = "applications",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface AgenticApplications {
  /**
   * Gets an Agentic Application by name.
   */
  @tag("AgenticApplication")
  get is ArmResourceRead<
    AgenticApplication,
    Response = ArmResponse<AgenticApplication>
  >;

  /**
   * Creates or updates an Agentic Application (asynchronous).
   */
  @tag("AgenticApplication")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AgenticApplication,
    Response = ArmResponse<AgenticApplication> | ArmResourceCreatedResponse<
      AgenticApplication,
      LroHeaders = ArmLroLocationHeader<FinalResult = AgenticApplication> & {
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
   * Delete Agentic Application.
   */
  @tag("AgenticApplication")
  delete is ArmResourceDeleteWithoutOkAsync<AgenticApplication>;

  /**
   * Lists Agentic Applications in the project.
   */
  @tag("AgenticApplication")
  list is ArmResourceListByParent<
    AgenticApplication,
    Parameters = AgenticApplicationsListParameters,
    Response = ArmResponse<AgenticApplicationResourceArmPaginatedResult>
  >;

  /**
   * Lists agents for an Agentic Application.
   */
  @tag("AgenticApplication")
  listAgents is ArmResourceActionSync<
    AgenticApplication,
    void,
    ArmResponse<AgentReferenceResourceArmPaginatedResult>
  >;

  /**
   * Enables an Agentic Application.
   */
  @tag("AgenticApplication")
  enable is ArmResourceActionSync<AgenticApplication, void, OkResponse>;

  /**
   * Disables an Agentic Application.
   */
  @tag("AgenticApplication")
  disable is ArmResourceActionSync<AgenticApplication, void, OkResponse>;
}

@@doc(AgenticApplication.name, "Name for the Agentic Application.");
@@doc(AgenticApplication.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(AgenticApplications.createOrUpdate::parameters.resource,
  "Agentic Application definition object."
);
@@summary(AgenticApplications.list, "Lists Agentic Applications in the project.");
@@summary(AgenticApplications.get, "Gets an Agentic Application by name.");
@@summary(AgenticApplications.createOrUpdate,
  "Creates or updates an Agentic Application (asynchronous)."
);
@@summary(AgenticApplications.delete, "Delete Agentic Application.");
@@summary(AgenticApplications.disable, "Disables an Agentic Application.");
@@summary(AgenticApplications.enable, "Enables an Agentic Application.");
@@summary(AgenticApplications.listAgents,
  "Lists agents for an Agentic Application."
);
