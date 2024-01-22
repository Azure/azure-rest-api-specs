import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Help;
/**
 * Solution response.
 */
model SolutionResource is ExtensionResource<SolutionResourceProperties> {
  /**
   * Solution resource Name.
   */
  @maxLength(100)
  @minLength(1)
  @pattern("^[A-Za-z0-9-+@()_]+$")
  @path
  @key("solutionResourceName")
  @segment("solutions")
  name: string;
}

@armResourceOperations
interface SolutionResources {
  /**
   * Get the solution using the applicable solutionResourceName while creating the solution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Solution_Get")
  get is ArmResourceRead<SolutionResource>;

  /**
   * Creates a solution for the specific Azure resource or subscription using the triggering criteria ‘solutionId and requiredInputs’ from discovery solutions.&lt;br/&gt; Solutions are a rich, insightful and a centralized self help experience that brings all the relevant content to troubleshoot an Azure issue into a unified experience. Solutions include the following components : Text, Diagnostics , Troubleshooters, Images , Video tutorials, Tables , custom charts, images , AzureKB, etc, with capabilities to support new solutions types in the future. Each solution type may require one or more ‘requiredParameters’ that are required to execute the individual solution component. In the absence of the ‘requiredParameters’ it is likely that some of the solutions might fail execution, and you might see an empty response. &lt;br/&gt;&lt;br/&gt; &lt;b&gt;Note:&lt;/b&gt;  &lt;br/&gt;1. ‘requiredInputs’ from Discovery solutions response must be passed via ‘parameters’ in the request body of Solutions API. &lt;br/&gt;2. ‘requiredParameters’ from the Solutions response is the same as ‘ additionalParameters’ in the request for diagnostics &lt;br/&gt;3. ‘requiredParameters’ from the Solutions response is the same as ‘properties.parameters’ in the request for Troubleshooters
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Solution_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SolutionResource,
    BaseParameters<SolutionResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update the requiredInputs or additional information needed to execute the solution
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Solution_Update")
  update is ArmCustomPatchAsync<
    SolutionResource,
    SolutionPatchRequestBody,
    BaseParameters<SolutionResource>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(SolutionResources.create::parameters.resource,
  "json",
  "solutionRequestBody"
);
@@extension(SolutionResources.create::parameters.resource,
  "x-ms-client-name",
  "solutionRequestBody"
);
@@doc(SolutionResources.create::parameters.resource,
  "The required request body for this solution resource creation."
);
@@projectedName(SolutionResources.update::parameters.properties,
  "json",
  "solutionPatchRequestBody"
);
@@extension(SolutionResources.update::parameters.properties,
  "x-ms-client-name",
  "solutionPatchRequestBody"
);
@@doc(SolutionResources.update::parameters.properties,
  "The required request body for updating a solution resource."
);
