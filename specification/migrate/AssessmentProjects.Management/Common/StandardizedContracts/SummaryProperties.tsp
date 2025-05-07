import "./CommonModels.tsp";
import "./CommonAssessmentPropertiesEnums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

//
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Summary property doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Summary properties class.")
model SummaryProperties {
  @doc("The summary type")
  @visibility(Lifecycle.Read)
  summaryType?: SummaryType;

  @doc("The summary name")
  @visibility(Lifecycle.Read)
  summaryName?: string;

  @doc("The source details list.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  sources?: SourceDetails[];

  @doc("The target details list.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  targets?: TargetDetails[];

  @doc("The target source mapping.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  targetSourceMapping?: TargetSourcePair[];

  @doc("The cost components.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  costComponents?: CostDetailsCommon[];

  @doc("The cost components.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  savingsComponents?: SavingsDetailsCommon[];
}

@doc("Source details")
model SourceDetails {
  @doc("The source name.")
  @visibility(Lifecycle.Read)
  sourceName?: AssessmentSource;

  @doc("The source type.")
  @visibility(Lifecycle.Read)
  sourceType?: MigrateWorkloadType;

  @doc("The migration platform.")
  @visibility(Lifecycle.Read)
  platform?: MigrationPlatform;

  @doc("The count of a type of source.")
  @visibility(Lifecycle.Read)
  count?: int32;
}

@doc("Target details")
model TargetDetails {
  @doc("The target name.")
  @visibility(Lifecycle.Read)
  targetName?: AzureTarget;

  @doc("The target type.")
  @visibility(Lifecycle.Read)
  targetType?: MigrateWorkloadType;

  @doc("The migration platform.")
  @visibility(Lifecycle.Read)
  platform?: MigrationPlatform;

  @doc("The count of a type of source.")
  @visibility(Lifecycle.Read)
  count?: int32;
}

@doc("Target source pair")
model TargetSourcePair {
  @doc("The source name.")
  @visibility(Lifecycle.Read)
  sourceRef?: AssessmentSource;

  @doc("The target name.")
  @visibility(Lifecycle.Read)
  targetRef?: AzureTarget;

  @doc("The count of a type of source.")
  @visibility(Lifecycle.Read)
  sourceCount?: int32;

  @doc("The count of a type of target.")
  @visibility(Lifecycle.Read)
  targetCount?: int32;

  @doc("The migration details.")
  @visibility(Lifecycle.Read)
  migrationDetails?: MigrationDetails;

  @doc("The management details.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  managementDetails?: ManagementDetails[];

  @doc("The cost details.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  costDetails?: CostDetailsCommon[];

  @doc("The savings details.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  savingsDetails?: SavingsDetailsCommon[];

  @doc("The confidence score.")
  @visibility(Lifecycle.Read)
  confidenceScore?: float64;
}

@doc("Migration details.")
model MigrationDetails {
  @doc("The readiness summary.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  readinessSummary?: NameValuePair<CloudSuitabilityCommon, int32>[];

  @doc("The migration type")
  @visibility(Lifecycle.Read)
  migrationType?: MigrationType;
}

@doc("Management details.")
model ManagementDetails {
  @doc("The management summary name.")
  @visibility(Lifecycle.Read)
  name?: AzureManagementOfferingType;

  @doc("The management suitability summary.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  readinessSummary?: NameValuePair<CloudSuitabilityCommon, int32>[];
}
