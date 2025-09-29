import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Help;
/**
 * Solution response.
 */
model SolutionResource
  is Azure.ResourceManager.ExtensionResource<SolutionResourceProperties> {
  ...ResourceNameParameter<
    Resource = SolutionResource,
    KeyName = "solutionResourceName",
    SegmentName = "solutions",
    NamePattern = "^[A-Za-z0-9-+@()_]+$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SolutionResources {
  /**
   * Get the solution using the applicable solutionResourceName while creating the solution.
   */
  get is Extension.Read<Extension.ScopeParameter, SolutionResource>;

  /**
   * Creates a solution for the specific Azure resource or subscription using the inputs ‘solutionId and requiredInputs’ from discovery solutions. <br/> Azure solutions comprise a comprehensive library of self-help resources that have been thoughtfully curated by Azure engineers to aid customers in resolving typical troubleshooting issues. These solutions encompass: <br/> (1.) Dynamic and context-aware diagnostics, guided troubleshooting wizards, and data visualizations. <br/> (2.) Rich instructional video tutorials and illustrative diagrams and images. <br/> (3.) Thoughtfully assembled textual troubleshooting instructions. <br/> All these components are seamlessly converged into unified solutions tailored to address a specific support problem area.
   */
  create is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ScopeParameter,
    SolutionResource,
    OptionalRequestBody = true
  >;

  /**
   * Update the requiredInputs or additional information needed to execute the solution
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.Extension.CustomPatchAsync<
    Extension.ScopeParameter,
    SolutionResource,
    PatchModel = SolutionPatchRequestBody,
    Response = ArmResourceUpdatedResponse<SolutionResource> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = SolutionResource>> & {
      @bodyRoot
      _: SolutionResource;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Warm up the solution resource by preloading asynchronous diagnostics results into cache
   */
  @action("warmup")
  warmUp is Azure.ResourceManager.Extension.ActionSync<
    Extension.ScopeParameter,
    SolutionResource,
    SolutionWarmUpRequestBody,
    NoContentResponse,
    OptionalRequestBody = true
  >;
}

@@maxLength(SolutionResource.name, 100);
@@minLength(SolutionResource.name, 1);
@@doc(SolutionResource.name, "Solution resource Name.");
@@doc(SolutionResource.properties, "Solution result");
@@doc(SolutionResources.create::parameters.resource,
  "The required request body for this solution resource creation."
);
@@doc(SolutionResources.update::parameters.properties,
  "The required request body for updating a solution resource."
);
@@doc(SolutionResources.warmUp::parameters.body,
  "The required request body for warming up a solution resource."
);
