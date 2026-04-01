import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.EventGrid;
/**
 * Information of the private link resource.
 */
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

/**
 * Private link resource under a Domain.
 */
@parentResource(Domain)
model DomainPrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = DomainPrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DomainPrivateLinkResources {
  /**
   * Get properties of a private link resource.
   */
  get is ArmResourceRead<DomainPrivateLinkResource>;

  /**
   * List all the private link resources under a domain.
   */
  listByResource is ArmResourceListByParent<
    DomainPrivateLinkResource,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

/**
 * Private link resource under a Topic.
 */
@parentResource(Topic)
model TopicPrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = TopicPrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TopicPrivateLinkResources {
  /**
   * Get properties of a private link resource.
   */
  get is ArmResourceRead<TopicPrivateLinkResource>;

  /**
   * List all the private link resources under a topic.
   */
  listByResource is ArmResourceListByParent<
    TopicPrivateLinkResource,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

/**
 * Private link resource under a PartnerNamespace.
 */
@parentResource(PartnerNamespace)
model PartnerNamespacePrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PartnerNamespacePrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PartnerNamespacePrivateLinkResources {
  /**
   * Get properties of a private link resource.
   */
  get is ArmResourceRead<PartnerNamespacePrivateLinkResource>;

  /**
   * List all the private link resources under a partner namespace.
   */
  listByResource is ArmResourceListByParent<
    PartnerNamespacePrivateLinkResource,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}

@@doc(PrivateLinkResource.name,
  "The name of private link resource will be either topic, domain, partnerNamespace or namespace."
);
@@doc(PrivateLinkResource.properties,
  "Properties of the private link resource."
);
