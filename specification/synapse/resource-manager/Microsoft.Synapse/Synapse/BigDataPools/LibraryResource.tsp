import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace BigDataPools;
/**
 * Library response details
 */
model LibraryResource is Azure.ResourceManager.ProxyResource<
  LibraryInfo,
  false
> {
  ...ResourceNameParameter<
    Resource = LibraryResource,
    KeyName = "libraryName",
    SegmentName = "libraries",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias LibraryOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** Library name */
    @segment("libraries")
    @key
    @path
    libraryName: string;
  }
>;

@armResourceOperations
interface LibraryResources {
  /**
   * Get library by name in a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Library_Get")
  get is LibraryOps.Read<LibraryResource>;

  /**
   * List libraries in a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Libraries_ListByWorkspace")
  listByWorkspace is LibraryOps.List<
    LibraryResource,
    Response = ArmResponse<LibraryListResponse>
  >;
}

@@doc(LibraryResource.name, "Library name");
@@doc(LibraryResource.properties, "Library/package properties.");
