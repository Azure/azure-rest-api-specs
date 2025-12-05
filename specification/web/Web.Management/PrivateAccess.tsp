import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Description of the parameters of Private Access for a Web Site.
 */
@singleton("virtualNetworks")
@parentResource(Site)
model PrivateAccess
  is Azure.ResourceManager.ProxyResource<PrivateAccessProperties> {
  ...ResourceNameParameter<
    Resource = PrivateAccess,
    KeyName = "privateAccess",
    SegmentName = "privateAccess",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface PrivateAccessOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the web app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** undefined */
        @path
        @segment("privateAccess")
        @key
        virtualNetworks: "virtualNetworks",
      }
    > {}

@armResourceOperations
interface PrivateAccesses {
  /**
   * Description for Gets data around private site access enablement and authorized Virtual Networks that can access the site.
   */
  @summary("Gets data around private site access enablement and authorized Virtual Networks that can access the site.")
  getPrivateAccess is PrivateAccessOps.Read<
    PrivateAccess,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Sets data around private site access enablement and authorized Virtual Networks that can access the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Sets data around private site access enablement and authorized Virtual Networks that can access the site.")
  putPrivateAccessVnet is PrivateAccessOps.CreateOrUpdateSync<
    PrivateAccess,
    Response = ArmResourceUpdatedResponse<PrivateAccess>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface PrivateAccessOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the web app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** The name of the slot for the web app. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** undefined */
        @path
        @segment("privateAccess")
        @key
        virtualNetworks: "virtualNetworks",
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface PrivateAccessOperationGroup {
  /**
   * Description for Gets data around private site access enablement and authorized Virtual Networks that can access the site.
   */
  @summary("Gets data around private site access enablement and authorized Virtual Networks that can access the site.")
  getPrivateAccessSlot is PrivateAccessOperationGroupOps.Read<
    PrivateAccess,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Sets data around private site access enablement and authorized Virtual Networks that can access the site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Sets data around private site access enablement and authorized Virtual Networks that can access the site.")
  putPrivateAccessVnetSlot is PrivateAccessOperationGroupOps.CreateOrUpdateSync<
    PrivateAccess,
    Response = ArmResourceUpdatedResponse<PrivateAccess>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(PrivateAccess.name, "");
@@doc(PrivateAccess.properties, "PrivateAccess resource specific properties");
@@doc(PrivateAccesses.putPrivateAccessVnet::parameters.resource,
  "The information for the private access"
);
@@doc(PrivateAccessOperationGroup.putPrivateAccessVnetSlot::parameters.resource,
  "The information for the private access"
);
