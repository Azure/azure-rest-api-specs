import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Policy fragment contract details.
 */
@parentResource(ApiManagementServiceResource)
model PolicyFragmentContract
  is Azure.ResourceManager.ProxyResource<PolicyFragmentContractProperties> {
  ...ResourceNameParameter<
    Resource = PolicyFragmentContract,
    KeyName = "id",
    SegmentName = "policyFragments",
    NamePattern = "(^[\\w]+$)|(^[\\w][\\w\\-]+[\\w]$)"
  >;
}

@armResourceOperations
interface PolicyFragmentContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** A resource identifier. */
        @path
        @segment("policyFragments")
        @key
        @pattern("(^[\\w]+$)|(^[\\w][\\w\\-]+[\\w]$)")
        @minLength(1)
        @maxLength(80)
        id: string,
      }
    > {}

@armResourceOperations
interface PolicyFragmentContracts {
  /**
   * Gets a policy fragment.
   */
  get is PolicyFragmentContractOps.Read<
    PolicyFragmentContract,
    Parameters = {
      /**
       * Policy fragment content format.
       */
      @query("format")
      format?: PolicyFragmentContentFormat;
    },
    Response = ArmResponse<PolicyFragmentContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of a policy fragment.
   */
  getEntityTag is PolicyFragmentContractOps.CheckExistence<
    PolicyFragmentContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates a policy fragment.
   */
  createOrUpdate is PolicyFragmentContractOps.CreateOrUpdateAsync<
    PolicyFragmentContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyFragmentContract> &
      ArmCombinedLroHeaders<FinalResult = PolicyFragmentContract> & {
        /**
         * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<
      PolicyFragmentContract,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = PolicyFragmentContract>
    > & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes a policy fragment.
   */
  delete is PolicyFragmentContractOps.DeleteSync<
    PolicyFragmentContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Gets all policy fragments.
   */
  listByService is PolicyFragmentContractOps.List<
    PolicyFragmentContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter, orderBy | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| value | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * OData order by query option.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<PolicyFragmentCollection>
  >;

  /**
   * Lists policy resources that reference the policy fragment.
   */
  listReferences is PolicyFragmentContractOps.ActionSync<
    PolicyFragmentContract,
    void,
    ArmResponse<ResourceCollection>,
    Parameters = {
      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;
}
@armResourceOperations
interface WorkspacePolicyFragmentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,
      },
      {
        /** A resource identifier. */
        @path
        @segment("policyFragments")
        @key
        @pattern("(^[\\w]+$)|(^[\\w][\\w\\-]+[\\w]$)")
        @minLength(1)
        @maxLength(80)
        id: string,
      }
    > {}

@armResourceOperations
interface WorkspacePolicyFragment {
  /**
   * Gets a policy fragment.
   */
  get is WorkspacePolicyFragmentOps.Read<
    PolicyFragmentContract,
    Parameters = {
      /**
       * Policy fragment content format.
       */
      @query("format")
      format?: PolicyFragmentContentFormat;
    },
    Response = ArmResponse<PolicyFragmentContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of a policy fragment.
   */
  getEntityTag is WorkspacePolicyFragmentOps.CheckExistence<
    PolicyFragmentContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates a policy fragment.
   */
  createOrUpdate is WorkspacePolicyFragmentOps.CreateOrUpdateAsync<
    PolicyFragmentContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyFragmentContract> &
      ArmCombinedLroHeaders<FinalResult = PolicyFragmentContract> & {
        /**
         * Current entity state version
         */
        @header("ETag")
        etag: string;
      }) | (ArmResourceCreatedResponse<
      PolicyFragmentContract,
      LroHeaders = ArmCombinedLroHeaders<FinalResult = PolicyFragmentContract>
    > & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes a policy fragment.
   */
  delete is WorkspacePolicyFragmentOps.DeleteSync<
    PolicyFragmentContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Gets all policy fragments defined within a workspace.
   */
  listByService is WorkspacePolicyFragmentOps.List<
    PolicyFragmentContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter, orderBy | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| value | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * OData order by query option.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<PolicyFragmentCollection>
  >;

  /**
   * Lists policy resources that reference the policy fragment.
   */
  listReferences is WorkspacePolicyFragmentOps.ActionSync<
    PolicyFragmentContract,
    void,
    ArmResponse<ResourceCollection>,
    Parameters = {
      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;
}

@@maxLength(PolicyFragmentContract.name, 80);
@@minLength(PolicyFragmentContract.name, 1);
@@doc(PolicyFragmentContract.name, "A resource identifier.");
@@doc(PolicyFragmentContract.properties, "Properties of the Policy Fragment.");
@@doc(PolicyFragmentContracts.createOrUpdate::parameters.resource,
  "The policy fragment contents to apply."
);
@@doc(WorkspacePolicyFragment.createOrUpdate::parameters.resource,
  "The policy fragment contents to apply."
);
