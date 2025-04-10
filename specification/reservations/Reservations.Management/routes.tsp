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


namespace Microsoft.Capacity;



#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReservationOperationGroup {
/**
* List the reservations and the roll up counts of reservations group by provisioning states that the user has access to in the current tenant.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Reservation_ListAll")
@autoRoute
@get
@action("reservations")
listAll is ArmProviderActionSync<Response = ResourceListResult<ReservationResponse>,Parameters = {/**
* May be used to filter by reservation properties. The filter supports 'eq', 'or', and 'and'. It does not currently support 'ne', 'gt', 'le', 'ge', or 'not'. Reservation properties include sku/name, properties/{appliedScopeType, archived, displayName, displayProvisioningState, effectiveDateTime, expiryDate, expiryDateTime, provisioningState, quantity, renew, reservedResourceType, term, userFriendlyAppliedScopeType, userFriendlyRenewState}
*/
@query("$filter")
"$filter"?: string,/**
* May be used to sort order by reservation properties.
*/
@query("$orderby")
"$orderby"?: string,/**
* To indicate whether to refresh the roll up counts of the reservations group by provisioning states
*/
@query("refreshSummary")
"refreshSummary"?: string,/**
* The number of reservations to skip from the list before returning results
*/
@query("$skiptoken")
"$skiptoken"?: float32,/**
* The selected provisioning state
*/
@query("selectedState")
"selectedState"?: string,/**
* To number of reservations to return
*/
@query("take")
"take"?: float32}>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@summary("Get the regions and skus that are available for RI purchase for the specified Azure subscription.")
/**
* Get the regions and skus that are available for RI purchase for the specified Azure subscription.
*/
@autoRoute
@get
@action("catalogs")
getCatalog is ArmProviderActionSync<Response = CatalogsResult,Scope = SubscriptionActionScope,Parameters = {/**
* The type of the resource for which the skus should be provided.
*/
@query("reservedResourceType")
"reservedResourceType"?: string,...LocationParameter,/**
* Publisher id used to get the third party products
*/
@query("publisherId")
"publisherId"?: string,/**
* Offer id used to get the third party products
*/
@query("offerId")
"offerId"?: string,/**
* Plan id used to get the third party products
*/
@query("planId")
"planId"?: string,/**
* May be used to filter by Catalog properties. The filter supports 'eq', 'or', and 'and'.
*/
@query("$filter")
"$filter"?: string,/**
* The number of reservations to skip from the list before returning results
*/
@query("$skip")
"$skip"?: float32,/**
* To number of reservations to return
*/
@query("$take")
"$take"?: float32}>
@summary("Get list of applicable `Reservation`s.")
/**
* Get applicable `Reservation`s that are applied to this subscription or a resource group under this subscription.
*/
@autoRoute
@get
@action("appliedReservations")
getAppliedReservationList is ArmProviderActionSync<Response = AppliedReservations,Scope = SubscriptionActionScope,Parameters = {}>

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ReservationOrderOperationGroup {
@summary("Calculate price for a `ReservationOrder`.")
/**
* Calculate price for placing a `ReservationOrder`.
*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("ReservationOrder_Calculate")
@autoRoute
@action("calculatePrice")
calculate is ArmProviderActionSync<Request = PurchaseRequest,Response = CalculatePriceResponse>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CalculateExchangeOperationGroup {
@summary("Calculates the refund amounts and price of the new purchases.")
/**
* Calculates price for exchanging `Reservations` if there are no policy errors.
* 
*/
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("CalculateExchange_Post")
@autoRoute
@action("calculateExchange")
post is ArmProviderActionAsync<Request = CalculateExchangeRequest,Response = CalculateExchangeOperationResultResponse,LroHeaders = ArmAsyncOperationHeader & Azure.Core.Foundations.RetryAfterHeader>
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ExchangeOperationGroup {
@summary("Exchange Reservation(s)")
/**
* Returns one or more `Reservations` in exchange for one or more `Reservation` purchases.
* 
*/
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("Exchange_Post")
@autoRoute
@action("exchange")
post is ArmProviderActionAsync<Request = ExchangeRequest,Response = ExchangeOperationResultResponse,LroHeaders = ArmAsyncOperationHeader & Azure.Core.Foundations.RetryAfterHeader>
}