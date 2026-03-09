import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./CommonModel.tsp";
import "./SoftwareSubscriptionModel.tsp";
import "./SoftwareLicenseModel.tsp";
import "./LicenseSummaryModel.tsp";
import "./AmendmentModel.tsp";
import "./SoftwareBillingSubscriptionModel.tsp";

using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

/** Microsoft.SoftwarePlan Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.SoftwarePlan management service" })
@versioned(Microsoft.SoftwarePlan.Versions)
namespace Microsoft.SoftwarePlan;

/** The available API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface SoftwareSubscriptions {
  get is ArmResourceRead<
    SoftwareSubscription,
    Parameters = ExpandSoftwareSubscriptionQueryParameter
  >;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SoftwareSubscription>;
  update is ArmResourcePatchSync<
    SoftwareSubscription,
    SoftwareSubscriptionProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SoftwareSubscription>;
  listByResourceGroup is ArmResourceListByParent<SoftwareSubscription>;
  listBySubscription is ArmListBySubscription<SoftwareSubscription>;

  /** List software keys provisioned for this subscription */
  listKeys is ArmResourceActionSync<
    SoftwareSubscription,
    void,
    SoftwareKey[],
    Parameters = SoftwareSubscriptionsListKeysParameters
  >;
  cancel is ArmResourceActionAsync<
    SoftwareSubscription,
    void,
    SoftwareSubscription
  >;
  /** Initiates asynchronous auto-fulfillment of keys for all eligible product versions. */
  refreshFulfillment is ArmResourceActionAsync<
    SoftwareSubscription,
    void,
    OperationResult
  >;

  /** Validate if the given Software Subscription changes are valid under this resource group. */
  @post
  @action("validateUpdate")
  @armResourceAction(SoftwareSubscription)
  validateUpdate(
    ...ResourceInstanceParameters<SoftwareSubscription>,

    /** Software subscription update details to validate */
    @body body: SoftwareSubscriptionUpdateRequest,
  ): ArmResponse<ValidationResponse> | ErrorResponse;
}

@armResourceOperations
interface SoftwareLicenses {
  get is ArmResourceRead<SoftwareLicense>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SoftwareLicense>;
  delete is ArmResourceDeleteWithoutOkAsync<SoftwareLicense>;
  listByResourceGroup is ArmResourceListByParent<SoftwareLicense>;
  listBySubscription is ArmListBySubscription<SoftwareLicense>;
  update is ArmResourcePatchSync<SoftwareLicense, SoftwareLicenseProperties>;
}

/** SoftwareLicenseProductKeys resource operations for SoftwareLicense */
@armResourceOperations
interface SoftwareLicenseProductKeys {
  /** List product keys for a software license */
  list is ArmResourceListByParent<SoftwareLicenseProductKey>;
  /** Get product key by id */
  get is ArmResourceRead<SoftwareLicenseProductKey>;
  /** Show Full product key */
  showFullKey is ArmResourceActionSync<
    SoftwareLicenseProductKey,
    void,
    ShowFullSoftwareLicenseKeyResult
  >;
}

/** SoftwareLicenseProductDownloadOptions resource operations for SoftwareLicense */
@armResourceOperations
interface SoftwareLicenseProductDownloadOptions {
  /** List product download options for a software license */
  list is ArmResourceListByParent<SoftwareLicenseProductDownloadOption>;
  /** Get product download option by id */
  get is ArmResourceRead<SoftwareLicenseProductDownloadOption>;
  /** Generate download links for a product download option (POST action) */
  generateDownloadLinks is ArmResourceActionSync<
    SoftwareLicenseProductDownloadOption,
    SoftwareLicenseGenerateDownloadLinksInput,
    SoftwareLicenseGenerateDownloadLinksResponse
  >;
}

/** SoftwareBillingSubscriptions resource operations */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface contains extension resourceType which need a custom route tag"
interface SoftwareBillingSubscriptions {
  /** List SoftwareBillingSubscription resources by BillingAccount */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Using x-ms-pageable extensions for proper OpenAPI generation"
  @tag("SoftwareBillingSubscriptions")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/softwareBillingSubscriptions")
  @get
  @armResourceList(SoftwareBillingSubscription)
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  listByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,
    ...PaginationParameters,
  ): ArmResponse<ResourceListResult<SoftwareBillingSubscription>> | ErrorResponse;

  /** Get a SoftwareBillingSubscription */
  @tag("SoftwareBillingSubscriptions")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/softwareBillingSubscriptions/{softwareBillingSubscriptionName}")
  @get
  getByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,

    /** The ID that uniquely identifies a software billing subscription. */
    @path
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    softwareBillingSubscriptionName: string,

    ...ExpandSoftwareBillingSubscriptionQueryParameter,
  ): ArmResponse<SoftwareBillingSubscription> | ErrorResponse;

  /** Validate if the given changes for the software subscription corresponding to this software billing subscription are valid. */
  @tag("SoftwareSubscriptions")
  @tag("SoftwareBillingSubscriptions")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/softwareBillingSubscriptions/{softwareBillingSubscriptionName}/validateSoftwareSubscriptionUpdate")
  @post
  validateSoftwareSubscriptionUpdate(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,

    /** The ID that uniquely identifies a software billing subscription. */
    @path
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    softwareBillingSubscriptionName: string,

    /** The validation request body */
    @body
    body: SoftwareSubscriptionUpdateRequest,
  ): ArmResponse<ValidationResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface contains provider-level actions which need a custom route tag"
interface ProviderLevelActions {
  /** Validate if the given Software Subscription to be created is valid under this billing account. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Overwriting operationId to not include interface name for the provider level api"
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/tenantLevelValidateSoftwareSubscriptionCreate")
  @post
  @operationId("TenantLevelValidateSoftwareSubscriptionCreate")
  @tag("SoftwareSubscriptions")
  tenantLevelValidateSoftwareSubscriptionCreate(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,

    /** The validation request body */
    @body
    body: SoftwareSubscription,
  ): ArmResponse<ValidationResponse> | ErrorResponse;

  /** Validate if the given Software Subscription to be created is valid under this resource group. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Overwriting operationId to not include resourceType for the provider level api"
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SoftwarePlan/validateSoftwareSubscriptionCreate")
  @operationId("ValidateSoftwareSubscriptionCreate")
  @tag("SoftwareSubscriptions")
  validateSoftwareSubscriptionCreate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** Software subscription details to validate */
    @body body: SoftwareSubscription,
  ): ArmResponse<ValidationResponse> | ErrorResponse;

  /** Validate if the given Software License to be created is valid under this resource group. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Overwriting operationId to not include resourceType for the provider level api"
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SoftwarePlan/validateSoftwareLicenseCreate")
  @operationId("ValidateSoftwareLicenseCreate")
  @tag("SoftwareLicenses")
  validateSoftwareLicenseCreate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** Software license details to validate */
    @bodyRoot body: SoftwareLicense,
  ): ArmResponse<ValidationResponse> | ErrorResponse;
}

/** Amendment operations interface */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface contains ProxyOnly, extension, Tenant resourceType which need a custom route tag"
interface Amendments {
  /** Get an Amendment */
  @tag("Amendments")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/amendments/{amendmentId}")
  @get
  get(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,

    /** The amendment ID */
    @path amendmentId: string,
  ): Amendment | ErrorResponse;

  /** List Amendment resources by billing account */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Using x-ms-pageable and x-ms-odata extensions for proper OpenAPI generation"
  @tag("Amendments")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/amendments")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  listByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,
    ...AmendmentFilterParameter,
  ): AmendmentListResult | ErrorResponse;

  /** Create an Amendment. Only the authorized internal system may invoke this operation; other callers receive 403 Forbidden. */
  @tag("Amendments")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/amendments")
  @post
  create(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,

    /** Resource create parameters. */
    @body resource: AmendmentRequestModel,
  ): Amendment | ErrorResponse;
}

/** ProductKeys resource operations for SoftwareSubscription */
@armResourceOperations
interface ProductKeys {
  /** List product keys for a software subscription */
  list is ArmResourceListByParent<
    ProductKey,
    Parameters = ListProductKeysParameters
  >;
  /** Get product key by id */
  get is ArmResourceRead<ProductKey>;
  /** Show Full product key */
  showFullKey is ArmResourceActionSync<ProductKey, void, ShowFullKeyResult>;
  /** Process activation units offset for a product key */
  processActivationUnitsOffset is ArmResourceActionSync<
    ProductKey,
    ProcessActivationUnitsOffsetInput,
    ProductKey
  >;
  /** Replace a product key */
  replaceKey is ArmResourceActionSync<ProductKey, ReplaceKeyInput, ProductKey>;
}

/** ProductDownloadOptions resource operations for SoftwareSubscription */
@armResourceOperations
interface ProductDownloadOptions {
  /** List product download options for a software subscription */
  list is ArmResourceListByParent<ProductDownloadOption>;
  /** Get product download option by id */
  get is ArmResourceRead<ProductDownloadOption>;
  /** Generate download links for a product download option (POST action) */
  generateDownloadLinks is ArmResourceActionSync<
    ProductDownloadOption,
    GenerateDownloadLinksInput,
    GenerateDownloadLinksResponse
  >;
}

/** LicenseSummary operations */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface contains provider-level operations and singleton resourceTypes that require custom routes"
interface LicenseSummary {
  /** List LicenseSummary resources by BillingAccount ID */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Using x-ms-pageable and x-ms-odata extensions for proper OpenAPI generation"
  @tag("LicenseSummary")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/licenseSummary/default")
  @get
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  @extension("x-ms-odata", "#/definitions/LicenseSummaryResource")
  listByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,
  ): LicenseSummaryResult | ErrorResponse;

  /** Refresh license summary for a billing account */
  @tag("LicenseSummary")
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/providers/Microsoft.SoftwarePlan/refreshLicenseSummary")
  @post
  refreshByBillingAccount(
    ...ApiVersionParameter,
    ...BillingAccountNameParameter,
  ): ({
    @statusCode _: 202;
  } & ArmLroLocationHeader &
    Azure.Core.Foundations.RetryAfterHeader) | ErrorResponse;
}
