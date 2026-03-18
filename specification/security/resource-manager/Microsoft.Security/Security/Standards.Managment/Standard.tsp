import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Security Standard on a resource
 */
model Standard
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<StandardProperties> {
  ...ResourceNameParameter<
    Resource = Standard,
    KeyName = "standardId",
    SegmentName = "standards",
    NamePattern = ""
  >;

  /**
   * Kind of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  /**
   * Entity tag is used for comparing two or more entities from the same requested resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface Standards {
  /**
   * Get a specific security standard for the requested scope
   */
  get is ArmResourceRead<Standard>;

  /**
   * Create a security standard on the given scope.  Available only for custom standards.  Will create/update the required standard definitions.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Standard>;

  /**
   * Delete a security standard on a scope.
   */
  delete is ArmResourceDeleteSync<Standard>;

  /**
   * Get security standards on all your resources inside a scope
   */
  list is ArmResourceListByParent<
    Standard,
    Response = ArmResponse<StandardList>
  >;

  /**
   * Get a list of all relevant security standards over a subscription level scope.
   */
  listBySubscription is ArmListBySubscription<
    Standard,
    Response = ArmResponse<StandardList>
  >;
}

@@doc(Standard.name,
  "The Security Standard key - unique key for the standard type"
);
@@doc(Standard.properties, "Properties of a security standard");
@@doc(Standards.createOrUpdate::parameters.resource,
  "Custom security standard over a pre-defined scope"
);
