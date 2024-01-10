

``` yaml

library-name: Billing
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/6b08774c89877269e73e11ac3ecbd1bd4e14f5a0/specification/billing/resource-manager/readme.md
tag: package-2021-10
skip-csproj: true
modelerfour:
  flatten-payloads: false

request-path-to-resource-name:
  /providers/Microsoft.Billing/paymentMethods/{paymentMethodName}: BillingPaymentMethod
format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


rename-mapping:
  NextBillingCycleDetails.billingFrequency: NextBillingCycleBillingFrequency
  BillingSubscriptionAlias.properties.billingSubscriptionId: -|arm-id
  AutoRenew: BillingSubscriptionAutoRenewState
  Amount: BillingAmount
  RenewalTermDetails: SubscriptionRenewalTermDetails
  Reseller: CreatedSubscriptionReseller
  MoveBillingSubscriptionRequest: BillingSubscriptionMoveContent
  MoveBillingSubscriptionRequest.destinationInvoiceSectionId: -|arm-id
  ValidateMoveBillingSubscriptionEligibilityResult: BillingSubscriptionValidateMoveEligibilityResult
  ValidateMoveBillingSubscriptionEligibilityError: BillingSubscriptionValidateMoveEligibilityError
  PaymentMethod: BillingPaymentMethod
  PaymentMethod.properties.type: PaymentMethodType
  PaymentMethodLink: BillingPaymentMethodLink
  PaymentMethodProjectionProperties.id: PaymentMethodId|arm-id

directive:
  - from: billingSubscription.json
    where: $.definitions
    transform: >
      $.BillingSubscriptionProperties.properties.billingProfileId['x-ms-format'] = 'arm-id';
      $.BillingSubscriptionProperties.properties.invoiceSectionId['x-ms-format'] = 'arm-id';
      $.BillingSubscriptionProperties.properties.termDuration['format'] = 'duration';
      $.BillingSubscriptionSplitRequest.properties.termDuration['format'] = 'duration';
      $.RenewalTermDetails.properties.termDuration['format'] = 'duration';

```
