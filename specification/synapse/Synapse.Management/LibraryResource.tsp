import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Library response details
 */
@parentResource(Workspace)
model LibraryResource
  is Azure.ResourceManager.ProxyResource<LibraryInfo, false> {
  ...ResourceNameParameter<
    Resource = LibraryResource,
    KeyName = "libraryName",
    SegmentName = "libraries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LibraryResources {
  /**
   * Get library by name in a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Library_Get")
  get is ArmResourceRead<LibraryResource>;

  /**
   * List libraries in a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Libraries_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<
    LibraryResource,
    Response = ArmResponse<LibraryListResponse>
  >;
}

@@doc(LibraryResource.name, "Library name");
@@doc(LibraryResource.properties, "Library/package properties.");
