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
model ProjectCapabilityHostResource
  is Azure.ResourceManager.ProxyResource<ProjectCapabilityHost, false> {
  ...ResourceNameParameter<
    Resource = ProjectCapabilityHostResource,
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
  get is ArmResourceRead<ProjectCapabilityHostResource>;

  /**
   * Create or update project capabilityHost.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProjectCapabilityHostResource,
    Response = ArmResponse<ProjectCapabilityHostResource> | (ArmResourceCreatedResponse<
      ProjectCapabilityHostResource,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ProjectCapabilityHostResource>
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("x-ms-async-operation-timeout")
      @format("duration")
      asyncOperationTimeout: string;
    })
  >;

  /**
   * Delete project capabilityHost.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ProjectCapabilityHostResource,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = void> & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("x-ms-async-operation-timeout")
      @format("duration")
      asyncOperationTimeout: string;
    }> | NoContentResponse
  >;

  /**
   * List capabilityHost.
   */
  list is ArmResourceListByParent<
    ProjectCapabilityHostResource,
    Response = ArmResponse<ProjectCapabilityHostResourceArmPaginatedResult>
  >;
}

@@doc(ProjectCapabilityHostResource.name,
  "The name of the capability host associated with the Cognitive Services Resource"
);
@@doc(ProjectCapabilityHostResource.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(ProjectCapabilityHosts.createOrUpdate::parameters.resource,
  "CapabilityHost definition."
);
