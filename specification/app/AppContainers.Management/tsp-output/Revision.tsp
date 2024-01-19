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
@doc("Container App Revision.")
@parentResource(ContainerApp)
model Revision is ProxyResource<RevisionProperties> {
  @doc("Name of the Container App Revision.")
  @path
  @key("revisionName")
  @segment("revisions")
  name: string;
}

@armResourceOperations
interface Revisions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a revision of a Container App.")
  @operationId("ContainerAppsRevisions_GetRevision")
  getRevision is ArmResourceRead<Revision>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Revisions for a given Container App.")
  @operationId("ContainerAppsRevisions_ListRevisions")
  listRevisions is ArmResourceListByParent<
    Revision,
    {
      ...BaseParameters<Revision>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Activates a revision for a Container App")
  @operationId("ContainerAppsRevisions_ActivateRevision")
  activateRevision is ArmResourceActionSync<Revision, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deactivates a revision for a Container App")
  @operationId("ContainerAppsRevisions_DeactivateRevision")
  deactivateRevision is ArmResourceActionSync<Revision, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Restarts a revision for a Container App")
  @operationId("ContainerAppsRevisions_RestartRevision")
  restartRevision is ArmResourceActionSync<Revision, void, void>;
}
