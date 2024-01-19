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
@doc("A transformation object, containing all information associated with the named transformation. All transformations are contained under a streaming job.")
@parentResource(StreamingJob)
model Transformation is ProxyResource<TransformationProperties> {
  @doc("The name of the transformation.")
  @path
  @key("transformationName")
  @segment("transformations")
  name: string;
}

@armResourceOperations
interface Transformations {
  @doc("Gets details about the specified transformation.")
  get is ArmResourceRead<Transformation>;

  @doc("Creates a transformation or replaces an already existing transformation under an existing streaming job.")
  createOrReplace is ArmResourceCreateOrReplaceSync<
    Transformation,
    {
      ...BaseParameters<Transformation>;

      @doc("The ETag of the transformation. Omit this value to always overwrite the current transformation. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new transformation to be created, but to prevent updating an existing transformation. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;

  @doc("Updates an existing transformation under an existing streaming job. This can be used to partially update (ie. update one or two properties) a transformation without affecting the rest the job or transformation definition.")
  update is ArmCustomPatchSync<
    Transformation,
    Transformation,
    {
      ...BaseParameters<Transformation>;

      @doc("The ETag of the transformation. Omit this value to always overwrite the current transformation. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
}

@@projectedName(Transformations.createOrReplace::parameters.resource,
  "json",
  "transformation"
);
@@extension(Transformations.createOrReplace::parameters.resource,
  "x-ms-client-name",
  "transformation"
);
@@doc(Transformations.createOrReplace::parameters.resource,
  "The definition of the transformation that will be used to create a new transformation or replace the existing one under the streaming job."
);
@@projectedName(Transformations.update::parameters.properties,
  "json",
  "transformation"
);
@@extension(Transformations.update::parameters.properties,
  "x-ms-client-name",
  "transformation"
);
@@doc(Transformations.update::parameters.properties,
  "A Transformation object. The properties specified here will overwrite the corresponding properties in the existing transformation (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing transformation will remain the same and not change as a result of this PATCH operation."
);
