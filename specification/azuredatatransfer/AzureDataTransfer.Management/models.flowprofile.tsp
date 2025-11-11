import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.AzureDataTransfer;

/**
 * Defines the required request body for retrieving FlowProfile information for a provided pipeline.
 */
@added(Versions.v2025_05_30_preview)
model ListFlowProfilesRequest {
  /**
   * The name of the pipeline for which to retrieve associated FlowProfiles.
   */
  pipeline?: string;
}

/**
 * Defines the patchable properties for a FlowProfile resource.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfilePatch {
  /**
   * Properties of FlowProfile patch body.
   */
  properties?: FlowProfilePatchProperties;

  ...ManagedServiceIdentityProperty;
  ...ArmTagsProperty;
}

/**
 * Represents the updatable properties of a FlowProfile.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfilePatchProperties {
  /**
   * The current provisioning state of the FlowProfile resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * A description of the FlowProfile that defines the replication scenario.
   */
  description?: string;

  /**
   * A set of configurable rulesets applied to this FlowProfile.
   */
  rulesets?: FlowProfileRulesets;

  /**
   * The operational status of the FlowProfile.
   */
  status?: FlowProfileStatus;
}

/**
 * The FlowProfile Metadata used to concisely provide all publicly viewable information.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileMetadata {
  /**
   * The name of the parent Pipeline Azure resource associated with this FlowProfile.
   */
  pipeline: string;

  /**
   * The name of the FlowProfile.
   */
  name: string;

  /**
   * The data replication scenario handled by this FlowProfile. Please note, that this value cannot be updated after creation. See the FlowProfilePatchProperties to see updateable properties.
   */
  replicationScenario: DataClassType;

  /**
   * A guid represented as a string for the FlowProfile resource, assigned by the system.
   */
  flowProfileId: string;

  /**
   * The operational status of the FlowProfile.
   */
  status: FlowProfileStatus;

  /**
   * A description of the FlowProfile and its rulesets. The description should describe the flowprofile's purpose and rulesets applied.
   */
  description: string;
}

/**
 * Defines the full set of properties for a FlowProfile resource.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileProperties {
  /**
   * The current provisioning state of the FlowProfile.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * A guid represented as a string for the FlowProfile resource, assigned by the system.
   */
  @visibility(Lifecycle.Read)
  flowProfileId?: string;

  /**
   * The data replication scenario handled by this FlowProfile. Please not, that this value cannot be updated after creation.
   */
  replicationScenario: DataClassType;

  /**
   * The operational status of the FlowProfile.
   */
  status: FlowProfileStatus;

  /**
   * A user-defined description of the FlowProfile.
   */
  description: string;

  /**
   * A set of configurable rulesets applied to this FlowProfile.
   */
  rulesets?: FlowProfileRulesets;
}

/**
 * The allowed set of configurable rulesets for a FlowProfile resource, used during data replication. All rulesets are optional, and any ruleset configured will be applied to every applicable replicating data. Any data that fails a ruleset will be denied replication. If a ruleset is not configured then the ruleset is considered disabled and will not apply towards replicating data.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileRulesets {
  /**
   * Antivirus scanning rules for replicated data.
   */
  antivirus?: AntivirusRuleset;

  /**
   * Rules for handling archive files during replication.
   */
  archives?: ArchiveRuleset;

  /**
   * Rules that enforce minimum and maximum data size limits.
   */
  dataSize?: DataSizeRuleset;

  /**
   * Rules for filtering files based on MIME types.
   */
  mimeFilters?: MimeFilterRuleset;

  /**
   * Rules for filtering XML content using XSD schemas.
   */
  xmlFilters?: XmlFilterRuleset;

  /**
   * Rules for detecting and blocking specific text patterns.
   */
  textMatching?: TextMatchingRuleset;
}

/**
 * Antivirus scanning rules for replicating data. By default, all antivirus scanning solutions are disabled.
 */
@added(Versions.v2025_05_30_preview)
model AntivirusRuleset {
  /**
   * Optional. The list of antiviruses to be used as a scanning solution for replicating data.
   */
  avSolutions?: AntivirusSolutions[];
}

/**
 * The list of Antivirus solutions currently provided.
 */
@added(Versions.v2025_05_30_preview)
union AntivirusSolutions {
  string,

  /**
   * Option to use Microsoft Defender antivirus scanning software as the scanning solution.
   */
  Defender: "Defender",

  /**
   * Option to use the external ClamAV open-source software as an antivirus scanning solution.
   */
  ClamAv: "ClamAv",
}

/**
 * Rules for regulating supported archive files (BZip2, Cpio, Deb, GZip, Rpm, Tar, Zip) during data replication. All properties are optional and only the configured options will be applied against archives. As an example, suppose minimumSizeForExpansion is 10 MiB and maximumExpansionSizeLimit is 1 GiB. Then all archives smaller than 10 MiB will be treated as though the archive ruleset is disabled, although other rulesets will apply as usual. Furthermore, all archives at least 10 MiB in size but with a decompressed size greater than 1 GiB will fail the ruleset. All other archives will have their contents extracted and each extracted element will be applied to all rulesets.
 */
@added(Versions.v2025_05_30_preview)
model ArchiveRuleset {
  /**
   * Optional. Default is 0. The minimum archive file size (in bytes) required to trigger expansion during replication. Any archive file size below the configured threshold will skip the rest of the configured rulesets for archives.
   */
  @minValue(0)
  minimumSizeForExpansion?: int64 = 0;

  /**
   * Optional. The combined maximum size (in bytes) of all extracted files that an expanded archive is allowed to reach. Archives exceeding the max limit will be denied for replication.
   */
  @minValue(0)
  maximumExpansionSizeLimit?: int64;

  /**
   * Optional. The maximum depth of nested archives that can be expanded. Limits how many layers of embedded archives will be processed. Archives exceeding the max limit will be denied for replication.
   */
  @minValue(0)
  maximumDepthLimit?: int64;

  /**
   * Optional. Provides the multiplication value for an archive in total based on the initial object being validated. This value takes the root object size and multiplies it by this value to create a maximum. Once this maximum is exceeded, the archive is failed. Used to detect and block archives with suspiciously high compression (e.g., zip bombs).
   */
  @minValue(0)
  maximumCompressionRatioLimit?: float64;
}

/**
 * Defines rules that enforce minimum and maximum file size limits for data replication.
 */
@added(Versions.v2025_05_30_preview)
model DataSizeRuleset {
  /**
   * Optional. Specifies the maximum allowed size (in bytes) for files to be replicated. Any file size greater than maximum will be denied replication.
   */
  @minValue(0)
  maximum?: int64;

  /**
   * Optional. Default is 0. Specifies the minimum required size (in bytes) for a file to be eligible for replication. Any file size less than minimum will be denied replication.
   */
  @minValue(0)
  minimum?: int64 = 0;
}

/**
 * Rules for filtering files based on Media types (f.k.a MIME types).
 */
@added(Versions.v2025_05_30_preview)
model MimeFilterRuleset {
  /**
   * Specifies whether the filter is an allow list or deny list. For more detail, please refer to the FilterType model.
   */
  type?: FilterType;

  /**
   * Defines the Media types (f.k.a MIME types) and associated file extensions to be filtered. For more detail, please refer to the MimeTypeFiler model.
   */
  @identifiers(#["media", "extensions"])
  filters?: MimeTypeFilter[];
}

/**
 * Defines a list of Media types (f.k.a MIME Types) and associated file extensions subject to filtering.
 */
@added(Versions.v2025_05_30_preview)
model MimeTypeFilter {
  /**
   * The Media Types (f.k.a MIME types), following IANA standards (e.g., application/json, image/png). For a more detailed list of allowed media types please refer to the Tika documentation: https://github.com/apache/tika/blob/main/tika-core/src/main/resources/org/apache/tika/mime/tika-mimetypes.xml
   */
  @pattern(
    "^[a-z]+/[a-zA-Z0-9+\\-\\+.]+$",
    "Value must be a valid IANA Media type."
  )
  media?: string;

  /**
   * A list of file extensions associated with the specified Media type (e.g., .json, .png). To specify files with no extension, use an empty string ""."
   */
  extensions?: string[];
}

/**
 * Specifies whether the filter applies an allow or deny policy.
 */
@added(Versions.v2025_05_30_preview)
union FilterType {
  string,

  /**
   * Defines an allow filter used for allowlist.
   */
  Allow: "Allow",

  /**
   * Defines a denying filter used for blocklisting.
   */
  Deny: "Deny",
}

/**
 * Rules for filtering XML content using XSD schemas.
 */
@added(Versions.v2025_05_30_preview)
model XmlFilterRuleset {
  /**
   * The default XML namespace used for schema validation.
   */
  defaultNamespace?: string;

  /**
   * Defines the method for referencing the xml schema.
   */
  reference?: XmlReferenceType;

  /**
   * The inline XSD schema to be used for validation.
   */
  schema?: string;
}

/**
 * Specifies how to reference the XML for processing.
 */
@added(Versions.v2025_05_30_preview)
union XmlReferenceType {
  string,

  /**
   * Defines a referencing procedure where the xml schema will be provided inline.
   */
  Inline: "Inline",
}

/**
 * Rules for detecting and blocking specific text patterns. If a file contains a text pattern that is part of the configured deny list, the file will be denied.
 */
@added(Versions.v2025_05_30_preview)
model TextMatchingRuleset {
  /**
   * A list of text patterns to block, each with matching rules and case sensitivity options.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["text", "matchType", "caseSensitivity"]
  )
  deny?: {
    ...TextMatch;
  }[];
}

/**
 * Configuration options for the text matching ruleset. For example, if the configuration is to deny "hello world" for partial case-insensitive words then "chello worlds" would get detected and the resulting file would be denied.
 */
model TextMatch {
  /**
   * The word or phrase to match against replicated content. A phrase with spaces will be considered a single substring.
   */
  text: string;

  /**
   * Specifies the text matching condition for text comparison. For more detail please refer to the MatchType model.
   */
  @added(Versions.v2025_05_30_preview)
  matchType: MatchType = MatchType.Partial;

  /**
   * Specifies the text matching conditions based on casing. For more detail please refer to the Casing model.
   */
  @added(Versions.v2025_05_30_preview)
  caseSensitivity: Casing = Casing.Insensitive;
}

/**
 * The text pattern matching conditions for text comparison.
 */
@added(Versions.v2025_05_30_preview)
union MatchType {
  string,

  /**
   * The option to pattern match substrings within all text content. For example, "hello world" would be found in "chello worlds".
   */
  Partial: "Partial",

  /**
   * The option to pattern match the entire string explicitly. For example, "hello world" would NOT be found in "chello worlds".
   */
  Complete: "Complete",
}

/**
 * Text casing comparison options - diacritics casing is also supported.
 */
@added(Versions.v2025_05_30_preview)
union Casing {
  string,

  /**
   * Ignores casing when performing pattern matching. For example, "Hello World" would be found in "hello world".
   */
  Insensitive: "Insensitive",

  /**
   * Requires exact casing for the pattern match. For example, "Hello World" would NOT not be found in "hello world".
   */
  Sensitive: "Sensitive",
}
