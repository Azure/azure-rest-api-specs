import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SecurityUserConfiguration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Defines the security user rule collection.
 */
@parentResource(SecurityUserConfiguration)
model SecurityUserRuleCollection
  is Azure.ResourceManager.ProxyResource<SecurityUserRuleCollectionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = SecurityUserRuleCollection,
    KeyName = "ruleCollectionName",
    SegmentName = "ruleCollections",
    NamePattern = "^[a-zA-Z0-9_.-]*$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface SecurityUserRuleCollections {
  /**
   * Gets a network manager security user configuration rule collection.
   */
  get is ArmResourceRead<SecurityUserRuleCollection, Error = CloudError>;

  /**
   * Creates or updates a security user rule collection.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityUserRuleCollection, Error = CloudError>;

  /**
   * Deletes a Security User Rule collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<SecurityUserRuleCollection,
    Parameters = {
      /**
       * Deletes the resource even if it is part of a deployed configuration. If the configuration has been deployed, the service will do a cleanup deployment in the background, prior to the delete.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Lists all the security user rule collections in a security configuration, in a paginated format.
   */
  list is ArmResourceListByParent<SecurityUserRuleCollection,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }, Error = CloudError>;
}

@@doc(SecurityUserRuleCollection.name,
  "The name of the network manager security Configuration rule collection."
);
@@doc(SecurityUserRuleCollection.properties,
  "Indicates the properties for the network manager security user rule collection."
);
@@doc(SecurityUserRuleCollections.createOrUpdate::parameters.resource,
  "The Security User Rule Collection to create or update"
);
