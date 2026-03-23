import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace ResourceHistory;

alias ResultFormat = ResourceGraphCommon.ResultFormat;
alias DateTimeInterval = ResourceGraphCommon.DateTimeInterval;

/**
 * Describes a history request to be executed.
 */
model ResourcesHistoryRequest {
  /**
   * Azure subscriptions against which to execute the query.
   */
  subscriptions?: string[];

  /**
   * The resources query.
   */
  query?: string;

  /**
   * The history request evaluation options
   */
  options?: ResourcesHistoryRequestOptions;

  /**
   * Azure management groups against which to execute the query. Example: [ 'mg1', 'mg2' ]
   */
  managementGroups?: string[];
}

/**
 * The options for history request evaluation
 */
model ResourcesHistoryRequestOptions {
  /**
   * The time interval used to fetch history.
   */
  interval?: DateTimeInterval;

  /**
   * The maximum number of rows that the query should return. Overrides the page size when ```$skipToken``` property is present.
   */
  @maxValue(1000)
  @minValue(1)
  $top?: int32;

  /**
   * The number of rows to skip from the beginning of the results. Overrides the next page offset when ```$skipToken``` property is present.
   */
  @minValue(0)
  $skip?: int32;

  /**
   * Continuation token for pagination, capturing the next page size and offset, as well as the context of the query.
   */
  $skipToken?: string;

  /**
   * Defines in which format query result returned.
   */
  resultFormat?: ResultFormat;
}

alias ResourcesHistoryResult = Record<unknown>;
