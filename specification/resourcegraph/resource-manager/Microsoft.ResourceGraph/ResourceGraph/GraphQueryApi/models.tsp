import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace GraphQueryApi;

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
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Properties that contain a graph query.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * An azure resource object
 */
model Resource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name. This is GUID value. The display name should be assigned within properties field.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The location of the resource
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * This will be used to handle Optimistic Concurrency. If not present, it will always overwrite the existing resource without checking conflict.
   */
  etag?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Error message body that will indicate why the operation failed.
 */
@error
model GraphQueryError {
  /**
   * The error object.
   */
  error?: GraphQueryErrorError;
}

/**
 * The error object.
 */
model GraphQueryErrorError {
  /**
   * Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.
   */
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  message?: string;

  /**
   * The list of invalid fields send in request, in case of validation error.
   */
  @identifiers(#[])
  details?: ErrorFieldContract[];
}

/**
 * Error Field contract.
 */
model ErrorFieldContract {
  /**
   * Property level error code.
   */
  code?: string;

  /**
   * Human-readable representation of property-level error.
   */
  message?: string;

  /**
   * Property name.
   */
  target?: string;
}

/**
 * The parameters that can be provided when updating workbook properties properties.
 */
model GraphQueryUpdateParameters {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Graph query list result.
 */
model GraphQueryListResult is Azure.Core.Page<GraphQueryResource>;

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
