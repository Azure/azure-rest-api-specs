import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./GatewayContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Gateway certificate authority details.
 */
@parentResource(GatewayContract)
model GatewayCertificateAuthorityContract
  is Azure.ResourceManager.ProxyResource<GatewayCertificateAuthorityContractProperties> {
  ...ResourceNameParameter<
    Resource = GatewayCertificateAuthorityContract,
    KeyName = "certificateId",
    SegmentName = "certificateAuthorities",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface GatewayCertificateAuthorityContractsOps
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

        /** Gateway entity identifier. Must be unique in the current API Management service instance. Must not have value 'managed' */
        @path
        @segment("gateways")
        @key
        @minLength(1)
        @maxLength(80)
        gatewayId: string,
      },
      {
        /** Identifier of the certificate entity. Must be unique in the current API Management service instance. */
        @path
        @segment("certificateAuthorities")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        certificateId: string,
      },
      ResourceName = "ApiManagementGatewayCertificateAuthority"
    > {}
@armResourceOperations
interface GatewayCertificateAuthorityContracts {
  /**
   * Get assigned Gateway Certificate Authority details.
   */
  get is GatewayCertificateAuthorityContractsOps.Read<
    GatewayCertificateAuthorityContract,
    Response = ArmResponse<GatewayCertificateAuthorityContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Checks if Certificate entity is assigned to Gateway entity as Certificate Authority.
   */
  getEntityTag is GatewayCertificateAuthorityContractsOps.CheckExistence<
    GatewayCertificateAuthorityContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Assign Certificate entity to Gateway entity as Certificate Authority.
   */
  createOrUpdate is GatewayCertificateAuthorityContractsOps.CreateOrUpdateSync<
    GatewayCertificateAuthorityContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response =
      | (ArmResponse<GatewayCertificateAuthorityContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
      | (ArmResourceCreatedSyncResponse<GatewayCertificateAuthorityContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
  >;

  /**
   * Remove relationship between Certificate Authority and Gateway entity.
   */
  delete is GatewayCertificateAuthorityContractsOps.DeleteSync<
    GatewayCertificateAuthorityContract,
    Parameters = IfMatchHeaderParameter
  >;

  /**
   * Lists the collection of Certificate Authorities for the specified Gateway entity.
   */
  listByService is GatewayCertificateAuthorityContractsOps.List<
    GatewayCertificateAuthorityContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | eq, ne |  |</br>
       */
      @query("$filter")
      $filter?: string;

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
    Response = ArmResponse<GatewayCertificateAuthorityCollection>
  >;
}

@@maxLength(GatewayCertificateAuthorityContract.name, 80);
@@minLength(GatewayCertificateAuthorityContract.name, 1);
@@doc(
  GatewayCertificateAuthorityContract.name,
  "Identifier of the certificate entity. Must be unique in the current API Management service instance."
);
@@doc(
  GatewayCertificateAuthorityContract.properties,
  "Gateway certificate authority details."
);
@@doc(
  GatewayCertificateAuthorityContracts.createOrUpdate::parameters.resource,
  ""
);
