using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Premonition;

@doc("A collection of genomics samples and analyses")
model Library is TrackedResource<LibraryProperties> {
  @doc("Name of the library")
  @key("libraryName")
  @segment("libraries")
  @path
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[\\w\\-]{3,24}$")
  name: string;

  // ...ManagedSystemAssignedIdentityProperty cannot be decorated with versioning info
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Property identity is not valid in the resource envelope"
  @doc("The managed service identities assigned to this resource.")
  @added(Microsoft.Premonition.Versions.v2025_06_01_preview)
  identity?: CommonTypes.SystemAssignedServiceIdentity;
}

@doc("The properties of Library")
model LibraryProperties {
  @doc("Full qualified URL or connection string to an Azure storage account")
  @added(Microsoft.Premonition.Versions.v2025_04_01_preview)
  storageAccount: string;

  @doc("Default container name where all samples/analyses data will be stored")
  @added(Microsoft.Premonition.Versions.v2025_04_01_preview)
  @madeOptional(Microsoft.Premonition.Versions.v2025_06_01_preview)
  containerName?: string;

  @doc("The blob container URL where data files are stored")
  @removed(Microsoft.Premonition.Versions.v2025_04_01_preview)
  container: url;

  @doc("Provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Genetic sequence data from a biological sample")
@parentResource(Library)
model Sample is TrackedResource<SampleProperties> {
  @doc("Name of the sample")
  @key("sampleName")
  @segment("samples")
  @path
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[\\w\\-]{3,24}$")
  name: string;
}

@doc("The properties of Sample")
model SampleProperties {
  @doc("Description of this sample, such as source, collection method, etc.")
  description?: string;

  @doc("Container name where the files are stored. Falls back to Library.containerName if not provided.")
  @added(Microsoft.Premonition.Versions.v2025_06_01_preview)
  containerName?: string;

  @doc("Path to the data files in the Library container. Supported formats: fa fasta fq fastq fa.gz fasta.gz fq.gz fastq.gz bam")
  paths: Array<string>;

  @doc("Byte size of the data files, used for validation")
  @added(Microsoft.Premonition.Versions.v2025_04_01_preview)
  contentLengths?: Array<int64>;

  @doc("MD5 hash of the data files, used for validation")
  @added(Microsoft.Premonition.Versions.v2025_04_01_preview)
  contentHashMd5?: Array<string>;

  @doc("Provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Analysis of one or more samples")
@parentResource(Library)
model Analysis is TrackedResource<AnalysisProperties> {
  @doc("Name of the analysis")
  @key("analysisName")
  @segment("analyses")
  @path
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[\\w\\-]{3,24}$")
  name: string;
}

@doc("The properties of Analysis")
model AnalysisProperties {
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The sample names being analyzed")
  samples: Array<string>;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The settings for the analysis")
  settings: AnalysisSettings;

  @doc("Container name where the result is written to. Falls back to Library.containerName if not provided.")
  @added(Microsoft.Premonition.Versions.v2025_06_01_preview)
  containerName?: string;

  @visibility(Lifecycle.Read)
  @doc("The time this analysis started")
  startedAt?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The time this analysis finished")
  finishedAt?: utcDateTime;

  @doc("Provisioning state of the resource")
  @visibility(Lifecycle.Read)
  provisioningState?: AnalysisState;

  @visibility(Lifecycle.Read)
  @doc("The result if the analysis succeeded")
  result?: AnalysisResult;

  @visibility(Lifecycle.Read)
  @doc("The error if the analysis failed")
  @removed(Microsoft.Premonition.Versions.v2025_04_01_preview)
  error?: {
    code: string;
    message: string;
  };

  @visibility(Lifecycle.Read)
  @doc("The error if the analysis failed")
  @added(Microsoft.Premonition.Versions.v2025_04_01_preview)
  failureReason?: AnalysisError;
}

@doc("The error emitted while running an analysis")
model AnalysisError {
  @doc("Diagnostic code")
  code: string;

  @doc("Readable error details")
  message: string;
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

  @doc("Metagenomic analysis: identify the sources of genetic material in a sample")
  Metagenomics: "Metagenomics",
}

@doc("Base settings for analysis")
@discriminator("kind")
model AnalysisSettings {
  @doc("The type of the analysis")
  kind: AnalysisKind;
}

@doc("Settings for a metagenomic analysis")
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

@doc("Result for a metagenomic analysis")
model MetagenomicsAnalysisResult extends AnalysisResult {
  kind: AnalysisKind.Metagenomics;

  @added(Microsoft.Premonition.Versions.v2025_05_01_preview)
  @doc("Number of base pairs in all samples")
  totalNumberOfBasePairs: int64;

  @added(Microsoft.Premonition.Versions.v2025_05_01_preview)
  @doc("Sum of number of reads in all samples")
  totalNumberOfReads: int64;

  @added(Microsoft.Premonition.Versions.v2025_05_01_preview)
  @doc("Type of the reads, either 'short' or 'long'")
  readsType: ReadsType;

  @added(Microsoft.Premonition.Versions.v2025_05_01_preview)
  @doc("Average fraction of duplicate reads in all samples")
  averageReadDuplicationFraction: float64;

  @added(Microsoft.Premonition.Versions.v2025_05_01_preview)
  @doc("Minimum read length accross all samples")
  minReadLength: int32;

  @added(Microsoft.Premonition.Versions.v2025_05_01_preview)
  @doc("Maximum read length accross all samples")
  maxReadLength: int32;

  @doc("The version of taxonomy database used")
  taxonomyVersion: TaxonomyVersion;

  @removed(Microsoft.Premonition.Versions.v2025_05_01_preview)
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

@added(Microsoft.Premonition.Versions.v2025_05_01_preview)
@doc("Valid reads types")
union ReadsType {
  string,

  @doc("Short reads")
  short: "short",

  @doc("Long reads")
  long: "long",
}

@doc("Request to identify the sources of genetic material in a sample")
model IdentifyRequest {
  @doc("The name for the new analysis")
  @pattern("^[\\w\\-]{3,24}$")
  name: string;

  @doc("The settings for metagenomic analysis")
  settings: MetagenomicsAnalysisSettings;
}
