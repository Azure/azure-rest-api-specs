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
 * Container App Revision.
 */
@parentResource(ContainerApp)
model Revision is Azure.ResourceManager.ProxyResource<RevisionProperties> {
  ...ResourceNameParameter<
    Resource = Revision,
    KeyName = "revisionName",
    SegmentName = "revisions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ContainerAppsRevisions {
  /**
   * Get a revision of a Container App.
   */
  @summary("Get a revision of a Container App.")
  getRevision is ArmResourceRead<Revision, Error = DefaultErrorResponse>;

  /**
   * Get the Revisions for a given Container App.
   */
  @summary("Get the Revisions for a given Container App.")
  listRevisions is ArmResourceListByParent<
    Revision,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<RevisionCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Activates a revision for a Container App
   */
  @action("activate")
  @summary("Activates a revision for a Container App")
  activateRevision is ArmResourceActionSync<
    Revision,
    void,
    OkResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Deactivates a revision for a Container App
   */
  @action("deactivate")
  @summary("Deactivates a revision for a Container App")
  deactivateRevision is ArmResourceActionSync<
    Revision,
    void,
    OkResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Restarts a revision for a Container App
   */
  @action("restart")
  @summary("Restarts a revision for a Container App")
  restartRevision is ArmResourceActionSync<
    Revision,
    void,
    OkResponse,
    Error = DefaultErrorResponse
  >;
}

alias FunctionExtensionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Container App. */
    @path
    @segment("containerApps")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    containerAppName: string;

    /** Name of the Container App Revision. */
    @path
    @segment("revisions")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    revisionName: string;
  },
  {
    /** Name of the Function. */
    @path
    @segment("functions")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    functionAppName: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
interface FunctionsExtension {
  /**
   * Proxies a Functions host call to the function app backed by the container app.
   */
  @action("invoke")
  @summary("Proxies a Functions host call to the function app backed by the container app.")
  invokeFunctionsHost is FunctionExtensionOps.ActionSync<
    Revision,
    void,
    ArmResponse<string>
  >;
}

@@doc(Revision.name, "Name of the Container App Revision.");
@@doc(Revision.properties, "Revision resource specific properties");
