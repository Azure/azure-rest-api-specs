import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Build resource payload
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BuildService)
@includeInapplicableMetadataInPayload(false)
model Build extends ProxyResource {
  /**
   * The name of the build resource.
   */
  @path
  @key("buildName")
  @segment("builds")
  @visibility("read")
  name: string;

  /**
   * Properties of the build resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: BuildProperties;
}

@armResourceOperations
interface Builds {
  /**
   * Get a KPack build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_GetBuild")
  getBuild is ArmResourceRead<Build>;

  /**
   * Create or update a KPack build.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_CreateOrUpdateBuild")
  createOrUpdateBuild is ArmResourceCreateOrReplaceSync<Build>;

  /**
   * List KPack builds.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BuildService_ListBuilds")
  listBuilds is ArmResourceListByParent<Build>;
}

@@projectedName(Builds.createOrUpdateBuild::parameters.resource,
  "json",
  "build"
);
@@extension(Builds.createOrUpdateBuild::parameters.resource,
  "x-ms-client-name",
  "build"
);
@@doc(Builds.createOrUpdateBuild::parameters.resource,
  "Parameters for the create or update operation"
);
