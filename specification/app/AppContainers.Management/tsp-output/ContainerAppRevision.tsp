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
model ContainerAppRevision is ProxyResource<RevisionProperties> {
  @doc("Name of the Container App Revision.")
  @path
  @key("revisionName")
  @segment("revisions")
  name: string;
}

@armResourceOperations
interface ContainerAppRevisions {
  @doc("Get a revision of a Container App.")
  getRevision is ArmResourceRead<ContainerAppRevision>;
  @doc("Get the Revisions for a given Container App.")
  listRevisions is ArmResourceListByParent<
    ContainerAppRevision,
    {
      ...BaseParameters<ContainerAppRevision>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Activates a revision for a Container App")
  activateRevision is ArmResourceActionSync<ContainerAppRevision, void, void>;
  @doc("Deactivates a revision for a Container App")
  deactivateRevision is ArmResourceActionSync<ContainerAppRevision, void, void>;
  @doc("Restarts a revision for a Container App")
  restartRevision is ArmResourceActionSync<ContainerAppRevision, void, void>;
}
