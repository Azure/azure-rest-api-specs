import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataQuality;

/**
 * Create Rules for Assets
 */
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules")
@post
op createRules is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Business Domain
     */
    @path
    dataProductId: string;

    /**
     * Unique Identifier for Business Domain
     */
    @path
    dataAssetId: string;

    @bodyRoot
    body?: RuleEntity;
  },
  RuleEntity[]
>;

/**
 * Get Rules for Assets
 */
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules")
@get
op getRules is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Data Product
     */
    @path
    dataProductId: string;

    /**
     * Unique Identifier for Data Asset
     */
    @path
    dataAssetId: string;
  },
  RuleEntity[]
>;

/**
 * Update a rule
 */
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules/{ruleId}")
@put
op updateRule is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Data Product
     */
    @path
    dataProductId: string;

    /**
     * Unique Identifier for Data Asset
     */
    @path
    dataAssetId: string;

    /**
     * Unique Identifier for Rule
     */
    @path
    ruleId: string;

    @bodyRoot
    body?: RuleEntity;
  },
  RuleEntity
>;

/**
 * Delete a rule
 */
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules/{ruleId}")
@delete
op deleteRule is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Data Product
     */
    @path
    dataProductId: string;

    /**
     * Unique Identifier for Data Asset
     */
    @path
    dataAssetId: string;

    /**
     * Unique Identifier for Rule
     */
    @path
    ruleId: string;
  },
  void
>;

/**
 * Get a Rule
 */
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/global-rules/{ruleId}")
@get
op getRule is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Business Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Data Product
     */
    @path
    dataProductId: string;

    /**
     * Unique Identifier for Data Asset
     */
    @path
    dataAssetId: string;

    /**
     * Unique Identifier for Rule
     */
    @path
    ruleId: string;
  },
  RuleEntity
>;

/**
 * Create Bulk Rules for Assets
 */
@route("/business-domains/{businessDomainId}/data-products/{dataProductId}/data-assets/{dataAssetId}/bulk/global-rules")
@post
op createBulkRules is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique Identifier for Busienss Domain
     */
    @path
    businessDomainId: string;

    /**
     * Unique Identifier for Data Product
     */
    @path
    dataProductId: string;

    /**
     * Unique Identifier for Data Asset
     */
    @path
    dataAssetId: string;

    @bodyRoot
    body?: RuleEntity;
  },
  RuleEntity[]
>;
