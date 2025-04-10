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

namespace Microsoft.Support;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ServiceClassificationsNoSubscriptionOperationGroup {
  /**
   * Classify the list of right Azure services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceClassificationsNoSubscription_classifyServices")
  @autoRoute
  classifyServices is ArmProviderActionSync<
    Request = ServiceClassificationRequest,
    Response = ServiceClassificationOutput
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ServiceClassificationsOperationGroup {
  /**
   * Classify the list of right Azure services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceClassifications_classifyServices")
  @autoRoute
  classifyServices is ArmProviderActionSync<
    Request = ServiceClassificationRequest,
    Response = ServiceClassificationOutput,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ProblemClassificationsOperationGroup {
  /**
   * Classify the right problem classifications (categories) available for a specific Azure service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProblemClassifications_classifyProblems")
  @autoRoute
  classifyProblems is ArmProviderActionSync<
    Request = ProblemClassificationsClassificationInput,
    Response = ProblemClassificationsClassificationOutput,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Name of the Azure service for which the problem classifications need to be retrieved.
       */
      @pattern("^[0-9a-zA-Z_\\-. ]+$")
      @path
      @segment("services")
      problemServiceName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SupportTicketsOperationGroup {
  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for support ticket creation for the selected subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SupportTickets_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SupportTicketsNoSubscriptionOperationGroup {
  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for support ticket creation for the selected subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SupportTicketsNoSubscription_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityInput,
    Response = CheckNameAvailabilityOutput
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LookUpResourceIdOperationGroup {
  /**
   * This operation fetches ARM resource id of support resource type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("This operation fetches ARM resource id of support resource type.")
  @operationId("LookUpResourceId_Post")
  @autoRoute
  @action("lookUpResourceId")
  post is ArmProviderActionSync<
    Request = LookUpResourceIdRequest,
    Response = LookUpResourceIdResponse
  >;
}
