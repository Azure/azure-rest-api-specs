import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StreamingJob.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
/**
 * An input object, containing all information associated with the named input. All inputs are contained under a streaming job.
 */
@parentResource(StreamingJob)
model Input is Azure.ResourceManager.ProxyResource<InputProperties> {
  ...ResourceNameParameter<
    Resource = Input,
    KeyName = "inputName",
    SegmentName = "inputs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Inputs {
  /**
   * Gets details about the specified input.
   */
  get is ArmResourceRead<Input>;

  /**
   * Creates an input or replaces an already existing input under an existing streaming job.
   */
  createOrReplace is ArmResourceCreateOrReplaceSync<
    Input,
    Parameters = {
      /**
       * The ETag of the input. Omit this value to always overwrite the current input. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new input to be created, but to prevent updating an existing input. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      IfNoneMatch?: string;
    }
  >;

  /**
   * Updates an existing input under an existing streaming job. This can be used to partially update (ie. update one or two properties) an input without affecting the rest the job or input definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Input,
    PatchModel = Input,
    Parameters = {
      /**
       * The ETag of the input. Omit this value to always overwrite the current input. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;
    }
  >;

  /**
   * Deletes an input from the streaming job.
   */
  delete is ArmResourceDeleteSync<Input>;

  /**
   * Lists all of the inputs under the specified streaming job.
   */
  listByStreamingJob is ArmResourceListByParent<
    Input,
    Parameters = {
      /**
       * The $select OData query parameter. This is a comma-separated list of structural properties to include in the response, or "*" to include all properties. By default, all properties are returned except diagnostics. Currently only accepts '*' as a valid value.
       */
      @query("$select")
      $select?: string;
    }
  >;

  /**
   * Tests whether an input’s datasource is reachable and usable by the Azure Stream Analytics service.
   */
  test is ArmResourceActionAsync<
    Input,
    {
      /**
       * If the input specified does not already exist, this parameter must contain the full input definition intended to be tested. If the input specified already exists, this parameter can be left null to test the existing input as is or if specified, the properties specified will overwrite the corresponding properties in the existing input (exactly like a PATCH operation) and the resulting input will be tested.
       */
      @bodyRoot
      input?: Input;
    },
    ArmResponse<ResourceTestStatus>
  >;
}

@@doc(Input.name, "The name of the input.");
@@doc(Input.properties,
  "The properties that are associated with an input. Required on PUT (CreateOrReplace) requests."
);
@@doc(Inputs.createOrReplace::parameters.resource,
  "The definition of the input that will be used to create a new input or replace the existing one under the streaming job."
);
@@doc(Inputs.update::parameters.properties,
  "An Input object. The properties specified here will overwrite the corresponding properties in the existing input (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing input will remain the same and not change as a result of this PATCH operation."
);
