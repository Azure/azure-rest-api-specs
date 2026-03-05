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

@armResourceOperations(#{ omitTags: true })
interface ProjectCapabilityHosts {
  /**
   * Get project capabilityHost.
   */
  @tag("ProjectCapabilityHost")
  get is ArmResourceRead<ProjectCapabilityHost>;

  /**
   * Create or update project capabilityHost.
   */
  @tag("ProjectCapabilityHost")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProjectCapabilityHost,
    Response = ArmResponse<ProjectCapabilityHost> | (ArmResourceCreatedResponse<
      ProjectCapabilityHost,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ProjectCapabilityHost>
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
  @tag("ProjectCapabilityHost")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProjectCapabilityHost,
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
  @summary("List capabilityHost.")
  @tag("ProjectCapabilityHost")
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
