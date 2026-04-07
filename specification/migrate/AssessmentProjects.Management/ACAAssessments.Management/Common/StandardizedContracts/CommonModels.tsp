import "./CostComponent.tsp";
import "./ProductSupportStatus.tsp";
import "./CommonEnums.tsp";
import "../Enums/Enums.tsp";
import "./CommonAssessmentPropertiesEnums.tsp";
import "../Enums/Enums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("The generic name value pair.")
model NameValuePair<TName, TValue> {
  @doc("The name.")
  @visibility(Lifecycle.Read)
  name?: TName;

  @doc("The value.")
  @visibility(Lifecycle.Read)
  value?: TValue;
}

@doc("The cost details.")
model CostDetailsCommon {
  @doc("The savings options.")
  @visibility(Lifecycle.Read)
  savingOptions?: SavingsOptions;

  @doc("The sku cost details per azure offer type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  costDetail?: NameValuePair<CostType, float32>[];
}

@doc("The savings details.")
model SavingsDetailsCommon {
  @doc("The savings options.")
  @visibility(Lifecycle.Read)
  savingOptions?: SavingsOptions;

  @doc("The sku cost details per azure offer type.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  savingsDetail?: NameValuePair<SavingsType, float32>[];
}

@doc("More information details.")
model MoreInformation {
  @doc("The title of the information.")
  @visibility(Lifecycle.Read)
  title: string;

  @doc("The URL of the information.")
  @visibility(Lifecycle.Read)
  url: string;
}
