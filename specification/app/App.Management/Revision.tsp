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
interface Revisions {
  /**
   * Get a revision of a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisions_GetRevision")
  getRevision is ArmResourceRead<Revision>;

  /**
   * Get the Revisions for a given Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisions_ListRevisions")
  listRevisions is ArmResourceListByParent<
    Revision,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<RevisionCollection>
  >;

  /**
   * Activates a revision for a Container App
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisions_ActivateRevision")
  @action("activate")
  activateRevision is ArmResourceActionSync<Revision, void, OkResponse>;

  /**
   * Deactivates a revision for a Container App
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisions_DeactivateRevision")
  @action("deactivate")
  deactivateRevision is ArmResourceActionSync<Revision, void, OkResponse>;

  /**
   * Restarts a revision for a Container App
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsRevisions_RestartRevision")
  @action("restart")
  restartRevision is ArmResourceActionSync<Revision, void, OkResponse>;

  /**
   * Proxies a Functions host call to the function app backed by the container app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FunctionsExtension_InvokeFunctionsHost")
  @action("invoke")
  invokeFunctionsHost is ArmResourceActionSync<
    Revision,
    void,
    ArmResponse<string>,
    Parameters = {
      /**
       * Name of the Function App, the extension resource.
       */
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      functionAppName: string;
    }
  >;
}

@@doc(Revision.name, "Name of the Container App Revision.");
@@doc(Revision.properties, "Revision resource specific properties");
