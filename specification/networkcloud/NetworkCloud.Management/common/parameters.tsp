import "@azure-tools/typespec-azure-core";
import "@typespec/http";

using TypeSpec.Http;

namespace Microsoft.NetworkCloud;

/**
 * The If-Match header field makes the request method conditional on the recipient's having at least one current representation of the target resource, when the field-value is '*', or having a selected representation with an entity-tag that matches a member of the list of entity-tags provided in the field-value.
 */
model IfMatchParameter {
  /**
   * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
   */
  @header("If-Match")
  ifMatch?: string;
}

/**
 * The If-None-Match header field makes the request method conditional on the absence of any current representation of the target resource, when the field-value is '*', or having a selected representation with an entity-tag that does not match any of those listed in the field-value.
 */
model IfNoneMatchParameter {
  /**
   * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
   */
  @header("If-None-Match")
  ifNoneMatch?: string;
}

/**
 * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
 */
model SkipTokenParameter {
  /**
   * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
   */
  @query("$skipToken")
  $skipToken?: string;
}

/**
 * The maximum number of resources to return from the operation. Example: '$top=10'.
 */
model TopParameter {
  /**
   * The maximum number of resources to return from the operation. Example: '$top=10'.
   */
  @query("$top")
  $top?: int32;
}
