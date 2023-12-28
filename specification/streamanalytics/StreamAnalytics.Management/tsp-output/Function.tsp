import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StreamingJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StreamAnalytics;
@doc("A function object, containing all information associated with the named function. All functions are contained under a streaming job.")
@parentResource(StreamingJob)
model Function is ProxyResource<FunctionProperties> {
  @doc("The name of the function.")
  @key("functionName")
  @segment("functions")
  name: string;
}

@armResourceOperations
interface Functions {
  @doc("Gets details about the specified function.")
  get is ArmResourceRead<Function>;
  @doc("Creates a function or replaces an already existing function under an existing streaming job.")
  createOrReplace is ArmResourceCreateOrReplaceSync<
    Function,
    {
      ...BaseParameters<Function>;

      @doc("The ETag of the function. Omit this value to always overwrite the current function. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new function to be created, but to prevent updating an existing function. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates an existing function under an existing streaming job. This can be used to partially update (ie. update one or two properties) a function without affecting the rest the job or function definition.")
  update is ArmCustomPatchSync<
    Function,
    Function,
    {
      ...BaseParameters<Function>;

      @doc("The ETag of the function. Omit this value to always overwrite the current function. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes a function from the streaming job.")
  delete is ArmResourceDeleteSync<Function>;
  @doc("Lists all of the functions under the specified streaming job.")
  listByStreamingJob is ArmResourceListByParent<
    Function,
    {
      ...BaseParameters<Function>;

      @doc("The $select OData query parameter. This is a comma-separated list of structural properties to include in the response, or \"*\" to include all properties. By default, all properties are returned except diagnostics. Currently only accepts '*' as a valid value.")
      @query("$select")
      $select?: string;
    }
  >;
  @doc("Tests if the information provided for a function is valid. This can range from testing the connection to the underlying web service behind the function or making sure the function code provided is syntactically correct.")
  test is ArmResourceActionAsync<Function, Function, ResourceTestStatus>;
  @doc("Retrieves the default definition of a function based on the parameters specified.")
  retrieveDefaultDefinition is ArmResourceActionSync<
    Function,
    FunctionRetrieveDefaultDefinitionParameters,
    Function
  >;
}
