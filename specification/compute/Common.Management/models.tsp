import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";

using Http;
using OpenAPI;
using TypeSpec.Rest;

namespace Microsoft.Compute;

/* Provides the standard '$expand' query parameter. */
model $ExpandQueryParameter<T = string> {
  /** The expand expression to apply on the operation. */
  @query("$expand")
  $expand?: T;
}

/**
 * Api error.
 */
model ApiError {
  /**
   * The Api error details
   */
  @Azure.ResourceManager.identifiers(#["message", "target"])
  details?: ApiErrorBase[];

  /**
   * The Api inner error
   */
  innererror?: InnerError;

  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Api error base.
 */
model ApiErrorBase {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the particular error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Inner error details.
 */
model InnerError {
  /**
   * The exception type.
   */
  exceptiontype?: string;

  /**
   * The internal error message or exception dump.
   */
  errordetail?: string;
}

/**
 * An error response from the Compute service.
 */
@error
model CloudError {
  /**
   * Api error.
   */
  error?: ApiError;
}

/**
 * The Resource model definition with location property as optional.
 */
model ResourceWithOptionalLocation {
  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubResource {
  /**
   * Resource Id
   */
  id?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubResourceReadOnly {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@doc("Concrete proxy resource types can be created by aliasing this type using a specific property type.")
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.customAzureResource
model ProxySubResourceReadOnly<Properties extends {}>
  extends SubResourceReadOnly {
  @doc("The resource-specific properties for this resource.")
  properties?: Properties;

  /**
   * The name of the parent resource.
   */
  @path
  @visibility(Lifecycle.Read)
  @segment("parents")
  parentName: string;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

/**
 * The type of extendedLocation.
 */
union ExtendedLocationTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EdgeZone: "EdgeZone",
}
