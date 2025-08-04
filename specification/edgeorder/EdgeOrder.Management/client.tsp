import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EdgeOrder;

// csharp
@@clientName(AddressUpdateParameter, "EdgeOrderAddressPatch", "csharp");
@@clientName(OrderItemDetailsUpdateParameter,
  "EdgeOrderItemDetailsPatch",
  "csharp"
);
@@clientName(TypeSpec.Http.OkResponse, "EdgeOrderOkResponseResult", "csharp");
@@clientName(OrderItemUpdateParameter, "EdgeOrderItemPatch", "csharp");
