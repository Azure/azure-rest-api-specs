import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.AccessReview;
// FIXME: AttributeNamespace has no properties property
/**
 * An attribute namespace resource.
 */
@tenantResource
model AttributeNamespace is Azure.ResourceManager.ProxyResource<never> {
  ...ResourceNameParameter<
    Resource = AttributeNamespace,
    KeyName = "attributeNamespace",
    SegmentName = "attributeNamespaces",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AttributeNamespaces {
  /**
   * Gets the specified attribute namespace.
   */
  get is ArmResourceRead<
    AttributeNamespace,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = CloudError
  >;

  /**
   * Deletes the specified attribute namespace.
   */
  delete is ArmResourceDeleteSync<
    AttributeNamespace,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = CloudError
  >;

  /**
   * Creates a new attribute namespace.
   */
  @action("action")
  create is ArmResourceActionSync<
    AttributeNamespace,
    AttributeNamespaceCreateRequest,
    ArmResponse<AttributeNamespace>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = CloudError
  >;
}

@@doc(AttributeNamespace.name, "The name of the attribute namespace to get.");
@@doc(AttributeNamespaces.create::parameters.body,
  "Parameters for creating the attribute namespace."
);
