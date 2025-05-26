// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;


namespace Microsoft.ConfidentialLedger;



#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
/**
* To check whether a resource name is available.
*/
@autoRoute
checkNameAvailability is ArmProviderActionSync<Request = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,Response = Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,Scope = SubscriptionActionScope,Parameters = {}>