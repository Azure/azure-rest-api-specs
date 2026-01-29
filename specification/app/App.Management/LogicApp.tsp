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
@parentResource(ContainerApp)
model LogicApp is Azure.ResourceManager.ProxyResource<AnyObject> {
  ...ResourceNameParameter<
    Resource = LogicApp,
    KeyName = "logicAppName",
    SegmentName = "logicApps",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias containerAppExternalResource = Extension.ExternalResource<
  "Microsoft.App",
  "containerApps",
  "{containerAppName}"
>;

@armResourceOperations
interface LogicApps {
  /**
   * Gets a logic app extension resource.
   */
  get is ArmResourceRead<LogicApp>;

  /**
   * Create or update a Logic App extension resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<LogicApp>;

  /**
   * Deletes a Logic App extension resource
   */
  delete is ArmResourceDeleteSync<LogicApp>;

  /**
   * Creates or updates the artifacts for the logic app
   */
  deployWorkflowArtifacts is ArmResourceActionSync<
    LogicApp,
    WorkflowArtifacts,
    OkResponse,
    OptionalRequestBody = true
  >;

  /**
   * Gets logic app's connections.
   */
  listWorkflowsConnections is ArmResourceActionSync<
    LogicApp,
    void,
    ArmResponse<WorkflowEnvelope>
  >;

  /**
   * Proxies a the API call to the logic app backed by the container app.
   */
  invoke is ArmResourceActionSync<
    LogicApp,
    void,
    ArmResponse<AnyObject>,
    Parameters = {
      /**
       * The proxy path for the API call
       */
      @header
      `x-ms-logicApps-proxy-path`: string;

      /**
       * The proxy method for the API call
       */
      @header
      `x-ms-logicApps-proxy-method`: LogicAppsProxyMethod;
    }
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
