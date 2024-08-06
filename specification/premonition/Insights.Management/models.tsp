import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Premonition.Insights;

@doc("A collection of genomics samples and analysis")
model Library is TrackedResource<LibraryProperties> {
  // Defines required `name` parameter of the resource
  ...ResourceNameParameter<Library>;
}

@doc("The properties of Library")
model LibraryProperties {
  @doc("The blob container URL where data files are stored")
  container: string;

  @visibility("read")
  @doc("The current status of the library")
  provisioningState?: ResourceProvisioningState;
}

@doc("Genetic sequence data from a biological sample")
@parentResource(Library)
model Sample is TrackedResource<SampleProperties> {
  // Defines required `name` parameter of the resource
  ...ResourceNameParameter<Sample>;
}

@doc("The properties of Sample")
model SampleProperties {
  @doc("Description")
  description?: string;

  @doc("Location of the fastq files")
  paths: Array<string>;

  @visibility("read")
  @doc("The current status of the library")
  provisioningState?: ResourceProvisioningState;
}

@doc("Analysis of one or more samples")
@parentResource(Library)
model Analysis is TrackedResource<AnalysisProperties> {
  // Defines required `name` parameter of the resource
  ...ResourceNameParameter<Analysis>;
}

@doc("The properties of Analysis")
model AnalysisProperties {
  @visibility("create")
  @doc("The samples being analyzed")
  samples: Array<string>;

  @visibility("create")
  @doc("The settings for the analysis")
  settings: AnalysisSettings;

  @visibility("read")
  @doc("The current status of the analysis")
  provisioningState?: AnalysisState;

  @visibility("read")
  @doc("The result of the analysis")
  result?: AnalysisResult;
}

@doc("The status of the analysis")
union AnalysisState {
  // standard Succeeded, Failed, Cancelled states
  ResourceProvisioningState,

  @doc("Submitted for processing")
  Queued: "Queued",

  @doc("In progress")
  Running: "Running",
}

@doc("Base settings for analysis")
@discriminator("type")
model AnalysisSettings {
  @doc("The type of the analysis")
  type: AnalysisType;
}

@doc("Settings for a metagenomics analysis")
model MetagenomicsAnalysisSettings extends AnalysisSettings {
  type: "Metagenomics";

  @doc("The version of taxonomy database to use")
  taxonomyVersion: TaxonomyVersion;
}

@doc("Base result of an analysis")
@discriminator("type")
model AnalysisResult {
  @doc("The type of the analysis")
  type: AnalysisType;

  @doc("The path to the output files")
  files?: Array<string>;
}

@doc("Supported types of analysis")
union AnalysisType {
  string,

  @doc("Metagenomics analysis: identify the sources of genetic material in a sample")
  Metagenomics: "Metagenomics",
}

@doc("Result for a metagenomics analysis")
model MetagenomicsAnalysisResult extends AnalysisResult {
  type: "Metagenomics";

  @doc("The number of pairs read")
  totalRead: TaxonomyVersion;
}

@doc("Valid taxonomy database versions")
union TaxonomyVersion {
  string,

  @doc("Taxonomy database derived from NCBI and COL as of 2020-07-06")
  v2020_07_06: "v2020_07_06",

  @doc("The latest version of the taxonomy database")
  Latest: "Latest",
}
