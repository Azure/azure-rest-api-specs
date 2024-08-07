using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Premonition;

@doc("A collection of genomics samples and analyses")
model Library is TrackedResource<LibraryProperties> {
  @doc("Name of the library")
  @key("libraryName")
  @segment("libraries")
  @path
  @visibility("read", "create")
  @pattern("^[\\w\\-]{3,24}$")
  name: string;
}

@doc("The properties of Library")
model LibraryProperties {
  @doc("The blob container URL where data files are stored")
  container: string;

  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Genetic sequence data from a biological sample")
@parentResource(Library)
model Sample is TrackedResource<SampleProperties> {
  @doc("Name of the sample")
  @key("sampleName")
  @segment("samples")
  @path
  @visibility("read", "create")
  @pattern("^[\\w\\-]{3,24}$")
  name: string;
}

@doc("The properties of Sample")
model SampleProperties {
  @doc("Description of this sample, such as source, collection method, etc.")
  description?: string;

  @doc("Location of the fastq files")
  paths: Array<string>;

  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Analysis of one or more samples")
@parentResource(Library)
model Analysis is TrackedResource<AnalysisProperties> {
  @doc("Name of the analysis")
  @key("analysisName")
  @segment("analyses")
  @path
  @visibility("read", "create")
  @pattern("^[\\w\\-]{3,24}$")
  name: string;
}

@doc("The properties of Analysis")
model AnalysisProperties {
  @visibility("create", "read")
  @doc("The sample names being analyzed")
  samples: Array<string>;

  @visibility("create", "read")
  @doc("The settings for the analysis")
  settings: AnalysisSettings;

  @visibility("read")
  @doc("The time this analysis started")
  startedAt?: utcDateTime;

  @visibility("read")
  @doc("The time this analysis finished")
  finishedAt?: utcDateTime;

  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: AnalysisState;

  @visibility("read")
  @doc("The result if the analysis succeeded")
  result?: AnalysisResult;

  @visibility("read")
  @doc("The error if the analysis failed")
  error?: {
    code: string;
    message: string;
  };
}

@doc("The status of an analysis")
union AnalysisState {
  // Succeeded: "Succeeded",
  // Failed: "Failed",
  // Canceled: "Canceled",
  ResourceProvisioningState,

  @doc("Submitted for processing")
  Queued: "Queued",

  @doc("In progress")
  Started: "Started",
}

@doc("Supported types of analysis")
union AnalysisKind {
  string,

  @doc("Metagenomics analysis: identify the sources of genetic material in a sample")
  Metagenomics: "Metagenomics",
}

@doc("Base settings for analysis")
@discriminator("kind")
model AnalysisSettings {
  @doc("The type of the analysis")
  kind: AnalysisKind;
}

@doc("Settings for a Metagenomics analysis")
model MetagenomicsAnalysisSettings extends AnalysisSettings {
  kind: AnalysisKind.Metagenomics;

  @doc("The version of taxonomy database to use. Default is the latest version.")
  taxonomyVersion?: TaxonomyVersion;
}

@doc("Base result of an analysis")
@discriminator("kind")
model AnalysisResult {
  @doc("The type of the analysis")
  kind: AnalysisKind;

  @doc("The path to the output files")
  files?: Array<string>;
}

@doc("Result for a Metagenomics analysis")
model MetagenomicsAnalysisResult extends AnalysisResult {
  kind: AnalysisKind.Metagenomics;

  @doc("The version of taxonomy database used")
  taxonomyVersion: TaxonomyVersion;

  @doc("The number of base pairs read")
  totalReads: int32;
}

@doc("Valid taxonomy database versions")
union TaxonomyVersion {
  string,

  @doc("Taxonomy database derived from NCBI and COL as of 2020-07-06")
  v2020_07_06: "v2020_07_06",

  @doc("The latest version of the taxonomy database")
  Latest: "Latest",
}
