import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using TypeSpec.Versioning;

using Azure.Core;

namespace Microsoft.DBforPostgreSQL;

/**
 * Name of the tuning option.
 */
union TuningOptionParameterEnum {
  string,

  /** Index related recommendations. */
  index: "index",

  /** Table related recommendations. */
  table: "table",
}

/**
 * Type for this recommendation.
 */
union RecommendationTypeEnum {
  string,

  /** Recommendation to create an index to improve query performance. */
  CreateIndex: "CreateIndex",

  /** Recommendation to drop an existing index because it's duplicate or unused. */
  DropIndex: "DropIndex",

  /** Recommendation to reindex an existing invalid index. */
  ReIndex: "ReIndex",

  /** Recommendation to analyze a table to update statistics for the query optimizer. */
  AnalyzeTable: "AnalyzeTable",

  /** Recommendation to vacuum a table to reclaim storage and optimize performance. */
  @added(Versions.v2026_01_01)
  VacuumTable: "VacuumTable",
}

/**
 * Recommendations list filter. Retrieves recommendations based on type.
 */
union RecommendationTypeParameterEnum {
  string,

  /** Recommendation to create an index to improve query performance. */
  CreateIndex: "CreateIndex",

  /** Recommendation to drop an existing index because it's duplicate or unused. */
  DropIndex: "DropIndex",

  /** Recommendation to reindex an existing invalid index. */
  ReIndex: "ReIndex",

  /** Recommendation to analyze a table to update statistics for the query optimizer. */
  AnalyzeTable: "AnalyzeTable",

  /** Recommendation to vacuum a table to reclaim storage and optimize performance. */
  @added(Versions.v2026_01_01)
  VacuumTable: "VacuumTable",
}

/**
 * Properties of a tuning option.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TuningOptionsProperties {
  /**
   * State of the tuning option.
   */
  @visibility(Lifecycle.Read)
  state?: string;
}

/**
 * List of available object recommendations.
 */
model ObjectRecommendationList is Azure.Core.Page<ObjectRecommendation>;

/**
 * Object recommendation properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ObjectRecommendation
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Always empty.
   */
  kind?: string;

  /**
   * Properties of an object recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  properties?: ObjectRecommendationProperties;
}

/**
 * Object recommendation properties.
 */
model ObjectRecommendationProperties {
  /**
   * Creation time (UTC) of this recommendation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  initialRecommendedTime?: utcDateTime;

  /**
   * Last time (UTC) that this recommendation was produced.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRecommendedTime?: utcDateTime;

  /**
   * Number of times this recommendation has been produced.
   */
  timesRecommended?: int32;

  /**
   * List of identifiers for all queries identified as targets for improvement if the recommendation is applied. The list is only populated for CREATE INDEX recommendations.
   */
  improvedQueryIds?: int64[];

  /**
   * Reason for this recommendation.
   */
  recommendationReason?: string;

  /**
   * Current state.
   */
  currentState?: string;

  /**
   * Type for this recommendation.
   */
  recommendationType?: RecommendationTypeEnum;

  /**
   * Implementation details for the recommended action.
   */
  implementationDetails?: ObjectRecommendationPropertiesImplementationDetails;

  /**
   * Workload information for the recommended action.
   */
  analyzedWorkload?: ObjectRecommendationPropertiesAnalyzedWorkload;

  /**
   * Estimated impact of this recommended action.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["dimensionName"])
  estimatedImpact?: ImpactRecord[];

  /**
   * Recommendation details for the recommended action.
   */
  @visibility(Lifecycle.Read)
  details?: ObjectRecommendationDetails;
}

/**
 * Implementation details for the recommended action.
 */
model ObjectRecommendationPropertiesImplementationDetails {
  /**
   * Method of implementation for recommended action.
   */
  method?: string;

  /**
   * Implementation script for the recommended action.
   */
  script?: string;
}

/**
 * Workload information for the recommended action.
 */
model ObjectRecommendationPropertiesAnalyzedWorkload {
  /**
   * Start time (UTC) of the workload analyzed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time (UTC) of the workload analyzed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Number of queries from the workload that were examined to produce this recommendation. For DROP INDEX recommendations it's 0 (zero).
   */
  queryCount?: int32;
}

/**
 * Impact on some metric if this recommended action is applied.
 */
model ImpactRecord {
  /**
   * Dimension name.
   */
  dimensionName?: string;

  /**
   * Dimension unit.
   */
  unit?: string;

  /**
   * Optional property that can be used to store the identifier of the query, if the metric is for a specific query.
   */
  queryId?: int64;

  /**
   * Absolute value.
   */
  absoluteValue?: float64;
}

/**
 * Recommendation details for the recommended action.
 */
model ObjectRecommendationDetails {
  /**
   * Database name.
   */
  databaseName?: string;

  /**
   * Schema name.
   */
  schema?: string;

  /**
   * Table name.
   */
  table?: string;

  /**
   * Index type.
   */
  indexType?: string;

  /**
   * Index name.
   */
  indexName?: string;

  /**
   * Index columns.
   */
  indexColumns?: string[];

  /**
   * Index included columns.
   */
  includedColumns?: string[];
}

/**
 * List of server tuning options.
 */
model TuningOptionsList is Azure.Core.Page<TuningOptions>;

@@identifiers(ObjectRecommendationList.value, #["name"]);

@@identifiers(TuningOptionsList.value, #["name"]);

/**
 * Impact on some metric if this recommended action is applied.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
model TuningOptions
  is Azure.ResourceManager.ProxyResource<TuningOptionsProperties> {
  ...ResourceNameParameter<
    Resource = TuningOptions,
    KeyName = "tuningOption",
    SegmentName = "tuningOptions",
    NamePattern = "",
    Type = TuningOptionParameterEnum
  >;
}

@armResourceOperations
interface TuningOptionsOperationGroup {
  /**
   * Gets the tuning options of a server.
   */
  get is ArmResourceRead<TuningOptions>;

  /**
   * Lists the tuning options of a server.
   */
  listByServer is ArmResourceListByParent<
    TuningOptions,
    Response = ArmResponse<TuningOptionsList>
  >;

  /**
   * Lists available object recommendations.
   */
  @get
  @list
  @action("recommendations")
  listRecommendations is ArmResourceActionSync<
    TuningOptions,
    void,
    ArmResponse<ObjectRecommendationList>,
    Parameters = {
      /**
       * Recommendations list filter. Retrieves recommendations based on type.
       */
      @query("recommendationType")
      recommendationType?: RecommendationTypeParameterEnum;
    }
  >;
}

@@doc(TuningOptions.name, "The name of the tuning option.");
