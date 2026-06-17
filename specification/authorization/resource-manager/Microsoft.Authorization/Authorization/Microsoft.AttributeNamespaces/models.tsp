import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Common;

namespace Microsoft.AccessReview;

/**
 * Request body for creating an attribute namespace.
 */
model AttributeNamespaceCreateRequest {
  /**
   * The principal ID of the namespace owner.
   */
  namespaceOwnerPrincipalId: string;
}
