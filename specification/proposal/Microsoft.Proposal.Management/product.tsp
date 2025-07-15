import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Proposal;

model ProductResource is ExtensionResource<ProductResourceProperties> {
  ...ResourceNameParameter<
    Resource = ProductResource,
    KeyName = "productCode",
    SegmentName = "products",
    NamePattern = "^[a-zA-Z0-9-]+$"
  >;
}

@doc("Details of the Proposal Product Item.")
model ProductResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The proposal status.")
  status?: ProposalStatus;
}

@route("/providers/Microsoft.Billing/billingAccounts")
@armResourceOperations(ProductResource)
interface ProductResources {
  get is ArmResourceRead<
    ProductResource,
    {
      ...ApiVersionParameter;

      /** The name of the billing account */
      @pattern("^[a-zA-Z0-9_:-]+$")
      @path("billingAccountName")
      billingAccountName: string;
    }
  >;
  listByParent is ArmResourceListByParent<
    ProductResource,
    {
      ...ApiVersionParameter;

      /** The name of the billing account */
      @pattern("^[a-zA-Z0-9_:-]+$")
      @path("billingAccountName")
      billingAccountName: string;
    }
  >;
}
