import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using Azure.Core;

/**
 * Namespace for client-only customization types. Types declared here are used to
 * shape the generated SDKs (via client customization decorators) but must never be
 * emitted into the OpenAPI/swagger output, so they live in a dedicated namespace
 * that the autorest emitter does not enumerate.
 */
namespace SearchClientCustomizations;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model `search-management-request-options` {
  /**
   * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
   */
  @header("x-ms-client-request-id")
  clientRequestId?: string;
}

/** Network security perimeter configuration */
model AccessRulePropertiesSubscriptionsItem {
  /** The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000') */
  id?: armResourceIdentifier;
}

/** Subscriptions for inbound rules */
model SearchServiceNetworkSecurityPerimeterInboundRuleSubscription {
  /** The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000') */
  id?: armResourceIdentifier;
}
