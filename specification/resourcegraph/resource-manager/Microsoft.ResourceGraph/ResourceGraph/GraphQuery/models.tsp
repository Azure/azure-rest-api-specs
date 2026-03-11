import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace GraphQuery;

/**
 * Enum indicating a type of graph query.
 */
union ResultKind {
  string,

  /**
   * basic
   */
  basic: "basic",
}

/**
 * Properties that contain a graph query.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model GraphQueryProperties {
  /**
   * Date and time in UTC of the last modification that was made to this graph query definition.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  /**
   * The description of a graph query.
   */
  description?: string;

  /**
   * KQL query that will be graph.
   */
  query: string;

  /**
   * Enum indicating a type of graph query.
   */
  @visibility(Lifecycle.Read)
  resultKind?: ResultKind;
}

/**
 * The parameters that can be provided when updating workbook properties properties.
 */
model GraphQueryUpdateParameters {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * This will be used to handle Optimistic Concurrency. If not present, it will always overwrite the existing resource without checking conflict.
   */
  etag?: string;

  /**
   * Metadata describing a graph query for an Azure resource.
   */
  properties?: GraphQueryPropertiesUpdateParameters;
}

/**
 * Properties that contain a workbook for PATCH operation.
 */
model GraphQueryPropertiesUpdateParameters {
  /**
   * The description of a graph query.
   */
  description?: string;

  /**
   * KQL query that will be graph.
   */
  query?: string;
}
