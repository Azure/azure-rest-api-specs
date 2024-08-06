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
  create is ArmResourceCreateOrReplaceSync<Library>;
  update is ArmResourcePatchSync<Library, LibraryProperties>;
  delete is ArmResourceDeleteSync<Library>;
  listByResourceGroup is ArmResourceListByParent<Library>;
  listBySubscription is ArmListBySubscription<Library>;
}

@armResourceOperations(Analysis)
interface AnalysisOperations {
  get is ArmResourceRead<Analysis>;
  create is ArmResourceCreateOrUpdateAsync<Analysis>;
  delete is ArmResourceDeleteWithoutOkAsync<Analysis>;
  listByParent is ArmResourceListByParent<Analysis>;
}

@armResourceOperations(Sample)
interface SampleOperations {
  get is ArmResourceRead<Sample>;
  create is ArmResourceCreateOrReplaceSync<Sample>;
  update is ArmResourcePatchSync<Sample, SampleProperties>;
  delete is ArmResourceDeleteSync<Sample>;
  listByParent is ArmResourceListByParent<Sample>;

  @put
  @doc("Create a metagenomics analysis of this sample")
  @armResourceCreateOrUpdate(Analysis)
  identify(
    ...Azure.ResourceManager.ApiVersionParameter,

    @doc("The name for the new analysis")
    @query
    @pattern("^[\\w\\-]{3,24}$")
    analysisName: string,

    @doc("The settings for metagenomics analysis")
    @bodyRoot
    settings: MetagenomicsAnalysisSettings,
  ): ArmResourceUpdatedResponse<Analysis> | ArmResourceCreatedResponse<Analysis> | ErrorResponse;
}
