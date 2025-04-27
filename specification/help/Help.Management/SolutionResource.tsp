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
@extensionResource
model SolutionResource
  is Azure.ResourceManager.ExtensionResource<SolutionResourceProperties> {
  ...ResourceNameParameter<
    Resource = SolutionResource,
    KeyName = "solutionResourceName",
    SegmentName = "solutions",
    NamePattern = "^[A-Za-z0-9-+@()_]+$"
  >;
}

@armResourceOperations
interface SolutionResources {
  /**
   * Get the solution using the applicable solutionResourceName while creating the solution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Solution_Get")
  get is ArmResourceRead<
    SolutionResource,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
       */
      @path
      scope: string;

      /**
       * Solution resource Name.
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      @path
      solutionResourceName: string;
    }
  >;

  /**
   * Creates a solution for the specific Azure resource or subscription using the inputs ‘solutionId and requiredInputs’ from discovery solutions. <br/> Azure solutions comprise a comprehensive library of self-help resources that have been thoughtfully curated by Azure engineers to aid customers in resolving typical troubleshooting issues. These solutions encompass: <br/> (1.) Dynamic and context-aware diagnostics, guided troubleshooting wizards, and data visualizations. <br/> (2.) Rich instructional video tutorials and illustrative diagrams and images. <br/> (3.) Thoughtfully assembled textual troubleshooting instructions. <br/> All these components are seamlessly converged into unified solutions tailored to address a specific support problem area.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Solution_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SolutionResource,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
       */
      @path
      scope: string;

      /**
       * Solution resource Name.
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      @path
      solutionResourceName: string;
    }
  >;

  /**
   * Update the requiredInputs or additional information needed to execute the solution
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Solution_Update")
  update is ArmCustomPatchAsync<
    SolutionResource,
    PatchModel = SolutionPatchRequestBody,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
       */
      @path
      scope: string;

      /**
       * Solution resource Name.
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      @path
      solutionResourceName: string;
    },
    Response = ArmResponse<SolutionResource>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Warm up the solution resource by preloading asynchronous diagnostics results into cache
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("warmup")
  @operationId("Solution_WarmUp")
  warmUp is ArmResourceActionSync<
    SolutionResource,
    {
      /**
       * The required request body for warming up a solution resource.
       */
      @bodyRoot
      solutionWarmUpRequestBody?: SolutionWarmUpRequestBody;
    },
    NoContentResponse,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
       */
      @path
      scope: string;

      /**
       * Solution resource Name.
       */
      @maxLength(100)
      @minLength(1)
      @pattern("^[A-Za-z0-9-+@()_]+$")
      @path
      solutionResourceName: string;
    }
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
