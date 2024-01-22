import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StreamingJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
/**
 * A function object, containing all information associated with the named function. All functions are contained under a streaming job.
 */
@parentResource(StreamingJob)
model Function is ProxyResource<FunctionProperties> {
  /**
   * The name of the function.
   */
  @path
  @key("functionName")
  @segment("functions")
  name: string;
}

@armResourceOperations
interface Functions {
  /**
   * Gets details about the specified function.
   */
  get is ArmResourceRead<Function>;

  /**
   * Creates a function or replaces an already existing function under an existing streaming job.
   */
  createOrReplace is ArmResourceCreateOrReplaceSync<
    Function,
    {
      ...BaseParameters<Function>;

      /**
       * The ETag of the function. Omit this value to always overwrite the current function. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new function to be created, but to prevent updating an existing function. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      IfNoneMatch?: string;
    }
  >;

  /**
   * Updates an existing function under an existing streaming job. This can be used to partially update (ie. update one or two properties) a function without affecting the rest the job or function definition.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    Function,
    Function,
    {
      ...BaseParameters<Function>;

      /**
       * The ETag of the function. Omit this value to always overwrite the current function. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;
    }
  >;

  /**
   * Deletes a function from the streaming job.
   */
  delete is ArmResourceDeleteSync<Function>;

  /**
   * Lists all of the functions under the specified streaming job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Functions_ListByStreamingJob")
  listByStreamingJob is ArmResourceListByParent<
    Function,
    {
      ...BaseParameters<Function>;

      /**
       * The $select OData query parameter. This is a comma-separated list of structural properties to include in the response, or "*" to include all properties. By default, all properties are returned except diagnostics. Currently only accepts '*' as a valid value.
       */
      @query("$select")
      $select?: string;
    }
  >;

  /**
   * Tests if the information provided for a function is valid. This can range from testing the connection to the underlying web service behind the function or making sure the function code provided is syntactically correct.
   */
  test is ArmResourceActionAsync<Function, Function, ResourceTestStatus>;

  /**
   * Retrieves the default definition of a function based on the parameters specified.
   */
  retrieveDefaultDefinition is ArmResourceActionSync<
    Function,
    FunctionRetrieveDefaultDefinitionParameters,
    Function
  >;
}

@@projectedName(Functions.createOrReplace::parameters.resource,
  "json",
  "function"
);
@@extension(Functions.createOrReplace::parameters.resource,
  "x-ms-client-name",
  "function"
);
@@doc(Functions.createOrReplace::parameters.resource,
  "The definition of the function that will be used to create a new function or replace the existing one under the streaming job."
);
@@projectedName(Functions.update::parameters.properties, "json", "function");
@@extension(Functions.update::parameters.properties,
  "x-ms-client-name",
  "function"
);
@@doc(Functions.update::parameters.properties,
  "A function object. The properties specified here will overwrite the corresponding properties in the existing function (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing function will remain the same and not change as a result of this PATCH operation."
);
@@projectedName(Functions.test::parameters.body, "json", "function");
@@extension(Functions.test::parameters.body, "x-ms-client-name", "function");
@@doc(Functions.test::parameters.body,
  "If the function specified does not already exist, this parameter must contain the full function definition intended to be tested. If the function specified already exists, this parameter can be left null to test the existing function as is or if specified, the properties specified will overwrite the corresponding properties in the existing function (exactly like a PATCH operation) and the resulting function will be tested."
);
@@projectedName(Functions.retrieveDefaultDefinition::parameters.body,
  "json",
  "functionRetrieveDefaultDefinitionParameters"
);
@@extension(Functions.retrieveDefaultDefinition::parameters.body,
  "x-ms-client-name",
  "functionRetrieveDefaultDefinitionParameters"
);
@@doc(Functions.retrieveDefaultDefinition::parameters.body,
  "Parameters used to specify the type of function to retrieve the default definition for."
);
