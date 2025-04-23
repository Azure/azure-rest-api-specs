import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BillingBenefits;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RoleAssignmentEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PurchaseRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReservationOrderAliasRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiscountPatchRequest.properties);

@@clientName(SavingsPlanOrderAliasModels.create::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SavingsPlanOrderAliasModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SavingsPlanOrderModel.properties);

@@clientName(SavingsPlanModels.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SavingsPlanModel.properties);

@@clientName(ReservationOrderAliasResponses.create::parameters.resource,
  "body"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReservationOrderAliasResponse.properties);

@@clientName(Discounts.create::parameters.resource, "body");
@@clientName(Discounts.update::parameters.properties, "body");
