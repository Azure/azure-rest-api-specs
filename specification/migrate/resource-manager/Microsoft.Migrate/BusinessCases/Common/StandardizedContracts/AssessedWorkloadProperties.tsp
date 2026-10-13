import "./CommonModels.tsp";
import "./CommonAssessmentPropertiesEnums.tsp";
import "../Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Assessed workload properties class.")
model AssessedWorkloadProperties<TLinkages, TRecommendations> {
  @doc("The workload type")
  @visibility(Lifecycle.Read)
  workloadType?: MigrateWorkloadType;

  @doc("The linkages list.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  linkages?: TLinkages[];

  @doc("The recommendation list.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recommendations?: TRecommendations[];
}

@doc("Linkages details")
model Linkages {
  @doc("The workload name")
  @visibility(Lifecycle.Read)
  workloadName?: string;

  @doc("The linkage type.")
  @visibility(Lifecycle.Read)
  linkageType?: LinkageType;

  @doc("The linkage kind.")
  @visibility(Lifecycle.Read)
  kind?: LinkageKind;

  @doc("The arm id.")
  @visibility(Lifecycle.Read)
  armId?: string;
}

@doc("Recommendation details")
model Recommendations<TMigrationIssues, TMigrationSuitability, TSkus> {
  @doc("The configuration data.")
  @visibility(Lifecycle.Read)
  configuration?: Configuration;

  @doc("The recommended details.")
  @visibility(Lifecycle.Read)
  recommendedFor?: RecommendedFor;

  @doc("The migration Platform.")
  @visibility(Lifecycle.Read)
  migrationPlatform?: MigrationPlatform;

  @doc("The confidence score.")
  @visibility(Lifecycle.Read)
  confidenceScore?: float32;

  @doc("The migration suitability.")
  @visibility(Lifecycle.Read)
  migrationSuitability?: TMigrationSuitability;

  @doc("The security suitability.")
  @visibility(Lifecycle.Read)
  securitySuitability?: SecuritySuitability;

  @doc("The total cost details.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  totalCost?: CostDetailsCommon[];

  @doc("The total cost details.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  totalSavings?: SavingsDetailsCommon[];

  @doc("The migration issues list.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  migrationIssues?: TMigrationIssues[];

  @doc("The Skus list.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  skus?: TSkus[];
}

@doc("The security suitability.")
model SecuritySuitability {
  @doc("The security suitability.")
  @visibility(Lifecycle.Read)
  readiness?: CloudSuitabilityCommon;
}

@doc("The migration suitability.")
model MigrationSuitability {
  @doc("The migration suitability.")
  @visibility(Lifecycle.Read)
  readiness?: CloudSuitabilityCommon;
}

@doc("Configuration details.")
model Configuration {
  @doc("The azure target.")
  @visibility(Lifecycle.Read)
  azureTarget?: AzureTarget;

  @doc("The azure target.")
  @visibility(Lifecycle.Read)
  sizingCriterion?: AssessmentSizingCriterion;
}

@doc("The recommended details.")
model RecommendedFor {
  @doc("The list of strategy type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  strategies?: StrategyType[];
}

@doc("Migration issues.")
model MigrationIssues {
  @doc("The issue id.")
  @visibility(Lifecycle.Read)
  issueCode?: string;

  @doc("The issue category.")
  @visibility(Lifecycle.Read)
  issueCategory?: MigrationIssuesCategory;

  @doc("The issue description.")
  @visibility(Lifecycle.Read)
  issueDescription?: string;

  @doc("The possible causes.")
  @visibility(Lifecycle.Read)
  possibleCause?: string;

  @doc("The recommended action.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  recommendedActions?: string[];

  @doc("The more information list.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  moreInformation?: MoreInformation[];
}

@doc("Skus details.")
model Skus<TMigrationSuitability> {
  @doc("The Sku kind.")
  @visibility(Lifecycle.Read)
  kind?: SkuKind;

  @doc("The resource uri.")
  @visibility(Lifecycle.Read)
  resourceUri?: string;

  @doc("The sku name.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("The sku id.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The sku type.")
  @visibility(Lifecycle.Read)
  type?: SkuType;

  @doc("The source name.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  sources?: SourceRecommendation<TMigrationSuitability>[];

  @doc("The sku details.")
  @visibility(Lifecycle.Read)
  details?: SkuDetails;
}

@doc("Source recommendation details.")
model SourceRecommendation<TMigrationSuitability> {
  @doc("The sku name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The sku type.")
  @visibility(Lifecycle.Read)
  migrationSuitability?: TMigrationSuitability;
}

@doc("Sku details.")
model SkuDetails {
  @doc("The sku type.")
  @visibility(Lifecycle.Read)
  skuType?: SkuType;

  @doc("The sku name.")
  @visibility(Lifecycle.Read)
  skuName?: string;

  @doc("The capabilities.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  capabilities?: NameValuePair<string, string>[];

  @doc("The sku cost details.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  totalCost?: CostDetailsCommon[];

  @doc("The sku savings details.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  totalSavings?: SavingsDetailsCommon[];
}
