import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Premonition.Insights;

@armResourceOperations(Library)
interface LibraryOperations {
  get is ArmResourceRead<Library>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Library>;
  update is ArmResourcePatchSync<Library, LibraryProperties>;
  delete is ArmResourceDeleteSync<Library>;
  listByResourceGroup is ArmResourceListByParent<Library>;
  listBySubscription is ArmListBySubscription<Library>;
}

@armResourceOperations(Analysis)
interface AnalysisOperations {
  get is ArmResourceRead<Analysis>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Analysis>;
  delete is ArmResourceDeleteSync<Analysis>;
  listByParent is ArmResourceListByParent<Analysis>;
}

@armResourceOperations(Sample)
interface SampleOperations {
  get is ArmResourceRead<Sample>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Sample>;
  update is ArmResourcePatchSync<Sample, SampleProperties>;
  delete is ArmResourceDeleteSync<Sample>;
  listByParent is ArmResourceListByParent<Sample>;

  @post
  @doc("Starts a metagenomics analysis of this sample")
  @armResourceAction(Analysis)
  identify(
    @doc("The name for the job")
    @query
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    jobName: string,

    @doc("The settings for metagenomics analysis")
    @body
    settings: MetagenomicsAnalysisSettings,

    ...Azure.ResourceManager.ApiVersionParameter,
  ): ArmResponse<Analysis> | ErrorResponse;
}
