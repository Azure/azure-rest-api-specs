import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Container App Revision.")
@parentResource(ContainerApp)
model Revision is ProxyResource<RevisionProperties> {
  @doc("Name of the Container App Revision.")
  @key("revisionName")
  @segment("revisions")
  name: string;
}

@armResourceOperations
interface ContainerAppsRevisions {
  @doc("Get a revision of a Container App.")
  getRevision is ArmResourceRead<Revision>;
  @doc("Get the Revisions for a given Container App.")
  listRevisions is ArmResourceListByParent<
    Revision,
    {
      ...BaseParameters<Revision>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Activates a revision for a Container App")
  activateRevision is ArmResourceActionSync<Revision, void, void>;
  @doc("Deactivates a revision for a Container App")
  deactivateRevision is ArmResourceActionSync<Revision, void, void>;
  @doc("Restarts a revision for a Container App")
  restartRevision is ArmResourceActionSync<Revision, void, void>;
}
