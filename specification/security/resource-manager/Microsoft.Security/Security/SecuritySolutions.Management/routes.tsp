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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AllowedConnectionsOperationGroup {
  /**
   * Gets the list of all possible traffic between resources for the subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AllowedConnections_List")
  @autoRoute
  @get
  @action("allowedConnections")
  list is ArmProviderActionSync<
    Response = AllowedConnectionsList,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DiscoveredSecuritySolutionsOperationGroup {
  /**
   * Gets a list of discovered Security Solutions for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiscoveredSecuritySolutions_List")
  @autoRoute
  @get
  @action("discoveredSecuritySolutions")
  list is ArmProviderActionSync<
    Response = DiscoveredSecuritySolutionList,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ExternalSecuritySolutionsOperationGroup {
  /**
   * Gets a list of external security solutions for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExternalSecuritySolutions_List")
  @autoRoute
  @get
  @action("externalSecuritySolutions")
  list is ArmProviderActionSync<
    Response = ExternalSecuritySolutionList,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface JitNetworkAccessPoliciesOperationGroup {
  /**
   * Policies for protecting resources using Just-in-Time access control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JitNetworkAccessPolicies_List")
  @autoRoute
  @get
  @action("jitNetworkAccessPolicies")
  list is ArmProviderActionSync<
    Response = JitNetworkAccessPoliciesList,
    Scope = SubscriptionActionScope
  >;
  /**
   * Policies for protecting resources using Just-in-Time access control for the subscription, location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JitNetworkAccessPolicies_ListByResourceGroup")
  @autoRoute
  @get
  @action("jitNetworkAccessPolicies")
  listByResourceGroup is ArmProviderActionSync<
    Response = JitNetworkAccessPoliciesList,
    Scope = Extension.ResourceGroup
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SecuritySolutionsOperationGroup {
  /**
   * Gets a list of Security Solutions for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SecuritySolutions_List")
  @autoRoute
  @get
  @action("securitySolutions")
  list is ArmProviderActionSync<
    Response = SecuritySolutionList,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SecuritySolutionsReferenceDataOperationGroup {
  /**
   * Gets a list of all supported Security Solutions for the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("securitySolutionsReferenceData_List")
  @autoRoute
  @get
  @action("securitySolutionsReferenceData")
  list is ArmProviderActionSync<
    Response = SecuritySolutionsReferenceDataList,
    Scope = SubscriptionActionScope
  >;
  /**
   * Gets list of all supported Security Solutions for subscription and location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SecuritySolutionsReferenceData_ListByHomeRegion")
  @autoRoute
  @get
  @action("securitySolutionsReferenceData")
  listByHomeRegion is ArmProviderActionSync<
    Response = SecuritySolutionsReferenceDataList,
    Scope = SubscriptionActionScope,
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface TopologyOperationGroup {
  /**
   * Gets a list that allows to build a topology view of a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Topology_List")
  @autoRoute
  @get
  @action("topologies")
  list is ArmProviderActionSync<
    Response = TopologyList,
    Scope = SubscriptionActionScope
  >;
}
