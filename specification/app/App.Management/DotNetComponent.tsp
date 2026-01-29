import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * .NET Component.
 */
model DotNetComponent
  is Azure.ResourceManager.ProxyResource<DotNetComponentProperties> {
  ...ResourceNameParameter<
    Resource = DotNetComponent,
    KeyName = "name",
    SegmentName = "dotNetComponents",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

@armResourceOperations
interface DotNetComponents {
  /**
   * Get a .NET Component.
   */
  get is ArmResourceRead<DotNetComponent>;

  /**
   * Creates or updates a .NET Component in a Managed Environment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DotNetComponent>;

  /**
   * Patches a .NET Component using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<DotNetComponent, PatchModel = DotNetComponent>;

  /**
   * Delete a .NET Component.
   */
  delete is ArmResourceDeleteWithoutOkAsync<DotNetComponent>;

  /**
   * Get the .NET Components for a managed environment.
   */
  list is ArmResourceListByParent<
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
