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
@doc("A transformation object, containing all information associated with the named transformation. All transformations are contained under a streaming job.")
@parentResource(StreamingJob)
model StreamingJobTransformation is ProxyResource<TransformationProperties> {
  @doc("The name of the transformation.")
  @path
  @key("transformationName")
  @segment("transformations")
  name: string;
}

@armResourceOperations
interface StreamingJobTransformations {
  @doc("Gets details about the specified transformation.")
  get is ArmResourceRead<StreamingJobTransformation>;
  @doc("Creates a transformation or replaces an already existing transformation under an existing streaming job.")
  createOrReplace is ArmResourceCreateOrReplaceSync<
    StreamingJobTransformation,
    {
      ...BaseParameters<StreamingJobTransformation>;

      @doc("The ETag of the transformation. Omit this value to always overwrite the current transformation. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new transformation to be created, but to prevent updating an existing transformation. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates an existing transformation under an existing streaming job. This can be used to partially update (ie. update one or two properties) a transformation without affecting the rest the job or transformation definition.")
  update is ArmResourcePatchSync<
    StreamingJobTransformation,
    TransformationProperties,
    {
      ...BaseParameters<StreamingJobTransformation>;

      @doc("The ETag of the transformation. Omit this value to always overwrite the current transformation. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
}
