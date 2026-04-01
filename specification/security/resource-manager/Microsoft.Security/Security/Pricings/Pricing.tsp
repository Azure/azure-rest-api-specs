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
 * Microsoft Defender for Cloud is provided in two pricing tiers: free and standard. The standard tier offers advanced security capabilities, while the free tier offers basic security features.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model Pricing is Azure.ResourceManager.ExtensionResource<PricingProperties> {
  ...ResourceNameParameter<
    Resource = Pricing,
    KeyName = "pricingName",
    SegmentName = "pricings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Pricings {
  /**
   * Get the Defender plans pricing configurations of the selected scope (valid scopes are resource id or a subscription id). At the resource level, supported resource types are 'VirtualMachines, VMSS and ARC Machines'.
   */
  get is Azure.ResourceManager.Extension.Read<
    Azure.ResourceManager.Extension.ScopeParameter,
    Pricing,
    Error = CloudError
  >;

  /**
   * Updates a provided Microsoft Defender for Cloud pricing configuration in the scope. Valid scopes are: subscription id or a specific resource id (Supported resources are: 'VirtualMachines, VMSS and ARC Machines' and only for plan='VirtualMachines' and subPlan='P1').
   */
  update is Azure.ResourceManager.Extension.CreateOrReplaceSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    Pricing,
    Error = CloudError
  >;

  /**
   * Deletes a provided Microsoft Defender for Cloud pricing configuration in a specific resource. Valid only for resource scope (Supported resources are: 'VirtualMachines, VMSS, ARC Machines, and Containers').
   */
  delete is Azure.ResourceManager.Extension.DeleteSync<
    Azure.ResourceManager.Extension.ScopeParameter,
    Pricing,
    Error = CloudError
  >;

  /**
   * Lists Microsoft Defender for Cloud pricing configurations of the scopeId, that match the optional given $filter. Valid scopes are: subscription id or a specific resource id (Supported resources are: 'VirtualMachines, VMSS and ARC Machines'). Valid $filter is: 'name in ({planName1},{planName2},...)'. If $filter is not provided, the unfiltered list will be returned. If '$filter=name in (planName1,planName2)' is provided, the returned list includes the pricings set for 'planName1' and 'planName2' only.
   */
  list is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.ScopeParameter,
    Pricing,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<PricingList>,
    Error = CloudError
  >;
}

@@doc(Pricing.name, "name of the pricing configuration");
@@doc(Pricing.properties, "Pricing data");
@@doc(Pricings.update::parameters.resource, "Pricing object");
