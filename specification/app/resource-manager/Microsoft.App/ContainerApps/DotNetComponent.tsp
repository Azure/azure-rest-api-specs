import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.App;
/**
 * .NET Component.
 */
@added(Versions.v2025_10_02_preview)
@removed(Versions.v2026_01_01)
@parentResource(ManagedEnvironment)
model DotNetComponent
  is Azure.ResourceManager.ProxyResource<DotNetComponentProperties> {
  ...ResourceNameParameter<
    Resource = DotNetComponent,
    KeyName = "name",
    SegmentName = "dotNetComponents",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias DotNetComponentOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;
  },
  {
    /** Name of the .NET Component. */
    @path
    @segment("dotNetComponents")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    name: string;
  }
>;

@added(Versions.v2025_10_02_preview)
@removed(Versions.v2026_01_01)
@armResourceOperations
interface DotNetComponents {
  /**
   * Get a .NET Component.
   */
  @summary("Get a .NET Component.")
  get is DotNetComponentOps.Read<DotNetComponent>;

  /**
   * Creates or updates a .NET Component in a Managed Environment.
   */
  @summary("Creates or updates a .NET Component.")
  createOrUpdate is DotNetComponentOps.CreateOrUpdateAsync<DotNetComponent>;

  /**
   * Patches a .NET Component using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a .NET Component")
  update is DotNetComponentOps.CustomPatchAsync<
    DotNetComponent,
    PatchModel = DotNetComponent
  >;

  /**
   * Delete a .NET Component.
   */
  @summary("Delete a .NET Component.")
  delete is DotNetComponentOps.DeleteWithoutOkAsync<DotNetComponent>;

  /**
   * Get the .NET Components for a managed environment.
   */
  @summary("Get the .NET Components for a managed environment.")
  list is DotNetComponentOps.List<
    DotNetComponent,
    Response = ArmResponse<DotNetComponentsCollection>
  >;
}

@@doc(DotNetComponent.name, "Name of the .NET Component.");
@@doc(DotNetComponent.properties,
  ".NET Component resource specific properties"
);
@@doc(DotNetComponents.createOrUpdate::parameters.resource,
  "Configuration details of the .NET Component."
);
@@doc(DotNetComponents.update::parameters.properties,
  "Configuration details of the .NET Component."
);
