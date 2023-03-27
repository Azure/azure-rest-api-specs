namespace DeveloperServicesApi.Models;

@doc("Product definition.")
model Product {
  @doc("Product identifier.")
  id: string;

  @doc("Product name.")
  name: string;

  @doc("Product description.")
  description: string;

  @doc("Product terms and conditions. Developer will have to accept these terms before he's allowed to call product API.")
  terms: string;

  @doc("Specifies whether a product subscription is required for accessing APIs included in this product. If true, the product is referred to as \"protected\" and a valid subscription key is required for a request to an API included in the product to succeed. If false, the product is referred to as \"open\" and requests to an API included in the product can be made without a subscription key. If property is omitted when creating a new product it's value is assumed to be true.")
  subscriptionRequired?: boolean;

  @doc("Specifies whether subscription approval is required. If false, new subscriptions will be approved automatically enabling developers to call the product’s APIs immediately after subscribing. If true, administrators must manually approve the subscription before the developer can call any of the product’s APIs. Can be present only if subscriptionRequired property is present and has a value of true.")
  approvalRequired?: boolean;

  @doc("Specifies the number of subscriptions a user can have to this product at the same time. Set to null or omit to allow unlimited per user subscriptions. Can be present only if subscriptionRequired property is present and has a value of false.")
  subscriptionsLimit?: int32;
}
