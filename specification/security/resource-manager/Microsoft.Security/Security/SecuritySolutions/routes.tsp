// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("AllowedConnections")
interface AllowedConnectionsOperationGroup {
  /**
   * Gets the list of all possible traffic between resources for the subscription
   */
  @autoRoute
  @list
  @get
  @action("allowedConnections")
  list is ArmProviderActionSync<
    Response = AllowedConnectionsList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("DiscoveredSecuritySolutions")
interface DiscoveredSecuritySolutionsOperationGroup {
  /**
   * Gets a list of discovered Security Solutions for the subscription.
   */
  @autoRoute
  @list
  @get
  @action("discoveredSecuritySolutions")
  list is ArmProviderActionSync<
    Response = DiscoveredSecuritySolutionList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("ExternalSecuritySolutions")
interface ExternalSecuritySolutionsOperationGroup {
  /**
   * Gets a list of external security solutions for the subscription.
   */
  @autoRoute
  @list
  @get
  @action("externalSecuritySolutions")
  list is ArmProviderActionSync<
    Response = ExternalSecuritySolutionList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("JitNetworkAccessPolicies")
interface JitNetworkAccessPoliciesOperationGroup {
  /**
   * Policies for protecting resources using Just-in-Time access control.
   */
  @autoRoute
  @list
  @get
  @action("jitNetworkAccessPolicies")
  list is ArmProviderActionSync<
    Response = JitNetworkAccessPoliciesList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  @autoRoute
  @list
  @get
  @action("jitNetworkAccessPolicies")
  listByResourceGroup is ArmProviderActionSync<
    Response = JitNetworkAccessPoliciesList,
    Scope = Extension.ResourceGroup,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("SecuritySolutions")
interface SecuritySolutionsOperationGroup {
  /**
   * Gets a list of Security Solutions for the subscription.
   */
  @autoRoute
  @list
  @get
  @action("securitySolutions")
  list is ArmProviderActionSync<
    Response = SecuritySolutionList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SecuritySolutionsReferenceDataOperationGroup {
  /**
   * Gets a list of all supported Security Solutions for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @operationId("securitySolutionsReferenceData_List")
  @tag("securitySolutionsReferenceData")
  @get
  @action("securitySolutionsReferenceData")
  list is ArmProviderActionSync<
    Response = securitySolutionsReferenceDataList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
  /**
   * Gets list of all supported Security Solutions for subscription and location.
   */
  @autoRoute
  @tag("SecuritySolutionsReferenceData")
  @get
  @action("securitySolutionsReferenceData")
  listByHomeRegion is ArmProviderActionSync<
    Response = securitySolutionsReferenceDataList,
    Scope = SubscriptionActionScope,
    Error = CloudError,
    Parameters = {
      /**
       * The location where ASC stores the data of the subscription. can be retrieved from Get locations
       */
      @path
      @segment("locations")
      ascLocation: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@tag("Topology")
interface TopologyOperationGroup {
  /**
   * Gets a list that allows to build a topology view of a subscription.
   */
  @autoRoute
  @list
  @get
  @action("topologies")
  list is ArmProviderActionSync<
    Response = TopologyList,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}
