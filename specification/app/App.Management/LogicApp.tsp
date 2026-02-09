import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * A logic app extension resource
 */
model LogicApp is Azure.ResourceManager.ProxyResource<LogicAppProperties> {
  ...ResourceNameParameter<
    Resource = LogicApp,
    KeyName = "logicAppName",
    SegmentName = "logicApps",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias LogicAppParentParameter = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** Name of the Container App. */
  @path
  @segment("providers/microsoft.App/containerApps")
  @key
  @pattern("^[-\\w\\._\\(\\)]+$")
  containerAppName: string;
};

@armResourceOperations
interface LogicApps {
  /**
   * Gets a logic app extension resource.
   */
  @summary("Gets a logic app extension resource.")
  get is ArmResourceRead<
    LogicApp,
    LogicAppParentParameter,
    Error = DefaultErrorResponse
  >;

  /**
   * Create or update a Logic App extension resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    LogicApp,
    LogicAppParentParameter,
    Error = DefaultErrorResponse
  >;

  /**
   * Deletes a Logic App extension resource
   */
  delete is ArmResourceDeleteSync<
    LogicApp,
    LogicAppParentParameter,
    Error = DefaultErrorResponse
  >;

  /**
   * Creates or updates the artifacts for the logic app
   */
  deployWorkflowArtifacts is ArmResourceActionSync<
    LogicApp,
    WorkflowArtifacts,
    OkResponse,
    LogicAppParentParameter,
    OptionalRequestBody = true,
    Error = DefaultErrorResponse
  >;

  /**
   * Gets logic app's connections.
   */
  @summary("Gets logic app's connections.")
  listWorkflowsConnections is ArmResourceActionSync<
    LogicApp,
    void,
    ArmResponse<WorkflowEnvelope>,
    LogicAppParentParameter,
    Error = DefaultErrorResponse
  >;

  /**
   * Proxies a the API call to the logic app backed by the container app.
   */
  @summary("Proxies a the API call to the logic app backed by the container app.")
  invoke is ArmResourceActionSync<
    LogicApp,
    void,
    ArmResponse<Object>,
    LogicAppParentParameter,
    Parameters = {
      /**
       * The proxy path for the API call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("x-ms-logicApps-proxy-path")
      `x-ms-logicApps-proxy-path`: string;

      /**
       * The proxy method for the API call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("x-ms-logicApps-proxy-method")
      `x-ms-logicApps-proxy-method`: LogicAppsProxyMethod;
    },
    Error = DefaultErrorResponse
  >;

  /**
   * Get workflow information by its name
   */
  @summary("Get workflow information by its name")
  getWorkflow is ArmResourceRead<
    WorkflowEnvelope,
    LogicAppParentParameter,
    Error = DefaultErrorResponse
  >;

  /**
   * List the workflows for a logic app.
   */
  @summary("List the workflows for a logic app.")
  listWorkflows is ArmResourceListByParent<
    WorkflowEnvelope,
    LogicAppParentParameter,
    Response = ArmResponse<WorkflowEnvelopeCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(LogicApp.name, "Name of the Logic App, the extension resource.");
@@doc(LogicApp.properties,
  "The resource-specific properties for this resource."
);
@@doc(LogicApps.createOrUpdate::parameters.resource,
  "Logic app resource properties."
);
@@doc(LogicApps.deployWorkflowArtifacts::parameters.body,
  "Application settings and files of the workflow."
);
