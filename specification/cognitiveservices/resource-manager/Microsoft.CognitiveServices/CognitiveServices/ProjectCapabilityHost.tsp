import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Azure Resource Manager resource envelope for Project CapabilityHost.
 */
@parentResource(Project)
model ProjectCapabilityHost
  is Azure.ResourceManager.ProxyResource<
    ProjectCapabilityHostProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ProjectCapabilityHost,
    KeyName = "capabilityHostName",
    SegmentName = "capabilityHosts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

@armResourceOperations
interface ProjectCapabilityHosts {
  /**
   * Get project capabilityHost.
   */
  get is ArmResourceRead<ProjectCapabilityHost>;

  /**
   * Create or update project capabilityHost.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProjectCapabilityHost>;

  /**
   * Delete project capabilityHost.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ProjectCapabilityHost>;

  /**
   * List capabilityHost.
   */
  list is ArmResourceListByParent<
    ProjectCapabilityHost,
    Response = ArmResponse<ProjectCapabilityHostResourceArmPaginatedResult>
  >;
}

@@doc(ProjectCapabilityHost.name,
  "The name of the capability host associated with the Cognitive Services Resource"
);
@@doc(ProjectCapabilityHost.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(ProjectCapabilityHosts.createOrUpdate::parameters.resource,
  "CapabilityHost definition."
);
