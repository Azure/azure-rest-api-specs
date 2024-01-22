import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App Revision.
 */
@parentResource(ContainerApp)
model Revision is ProxyResource<RevisionProperties> {
  /**
   * Name of the Container App Revision.
   */
  @path
  @key("revisionName")
  @segment("revisions")
  name: string;
}

@armResourceOperations
interface Revisions {
  /**
   * Get a revision of a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisions_GetRevision")
  getRevision is ArmResourceRead<Revision>;

  /**
   * Get the Revisions for a given Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisions_ListRevisions")
  listRevisions is ArmResourceListByParent<
    Revision,
    {
      ...BaseParameters<Revision>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Activates a revision for a Container App
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisions_ActivateRevision")
  activateRevision is ArmResourceActionSync<Revision, void, void>;

  /**
   * Deactivates a revision for a Container App
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisions_DeactivateRevision")
  deactivateRevision is ArmResourceActionSync<Revision, void, void>;

  /**
   * Restarts a revision for a Container App
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ContainerAppsRevisions_RestartRevision")
  restartRevision is ArmResourceActionSync<Revision, void, void>;
}
