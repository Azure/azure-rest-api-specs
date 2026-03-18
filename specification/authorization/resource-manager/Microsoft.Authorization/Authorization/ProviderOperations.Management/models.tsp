import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Authorization;

/**
 * Resource Type
 */
model ResourceType {
  /**
   * The resource type name.
   */
  name?: string;

  /**
   * The resource type display name.
   */
  displayName?: string;

  /**
   * The resource type operations.
   */
  @identifiers(#[])
  operations?: ProviderOperation[];
}

/**
 * Operation
 */
model ProviderOperation {
  /**
   * The operation name.
   */
  name?: string;

  /**
   * The operation display name.
   */
  displayName?: string;

  /**
   * The operation description.
   */
  description?: string;

  /**
   * The operation origin.
   */
  origin?: string;

  /**
   * The operation properties.
   */
  properties?: unknown;

  /**
   * The dataAction flag to specify the operation type.
   */
  isDataAction?: boolean;
}
