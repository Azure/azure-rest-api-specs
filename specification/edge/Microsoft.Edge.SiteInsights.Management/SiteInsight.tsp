import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

@doc("SiteInsight resource")
model SiteInsight
  is Azure.ResourceManager.ExtensionResource<SiteInsightProperties> {
  ...ResourceNameParameter<SiteInsight, NamePattern = "^default$">;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "ResourceProvisioningState is not needed since this resource is created via ARB and directly pushed to ARG"
@doc("Site Insight properties")
model SiteInsightProperties {
  @doc("SG ancestor chain")
  sgAncestorChain?: Array<string>;

  @doc("Classical ancestor chain")
  classicalAncestorChain?: Array<string>;
}

@doc("SiteInsight operations")
@armResourceOperations
interface SiteInsights {
  @doc("Get SiteInsight resource by name")
  get is ArmResourceRead<SiteInsight>;

  @doc("List all SiteInsight resources")
  list is ArmResourceListByParent<SiteInsight>;
}
