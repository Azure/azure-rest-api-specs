import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Premonition;

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

  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  create is ArmResourceCreateOrUpdateAsync<Analysis>;

  update is ArmResourcePatchSync<Analysis, AnalysisProperties>;

  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
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

  @doc("Create a Metagenomics analysis of this sample")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  identify is ArmResourceActionAsync<Sample, IdentifyRequest, Analysis>;
}
