import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";
import "./common.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents a connection between a workspace and a target resource.
 * A connection provisions and tracks the trust relationship used to reach the
 * data plane of a target resource for fault injection.
 */
@added(Microsoft.Chaos.Versions.v2026_08_01_preview)
@parentResource(Workspace)
model Connection is Azure.ResourceManager.ProxyResource<ConnectionProperties> {
  ...ResourceNameParameter<
    Resource = Connection,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
}

/**
 * Model that represents the properties of a connection.
 *
 * The schema is flat and discriminated by `kind`. Optional fields form the
 * superset across all connection kinds; which fields are required is
 * validated by the service per kind.
 */
@added(Microsoft.Chaos.Versions.v2026_08_01_preview)
model ConnectionProperties {
  /**
   * The kind of connection, indicating the actor type used to reach the target resource's data plane.
   */
  kind: ConnectionKind;

  /**
   * The fully qualified Azure resource ID of the target resource this connection is established with.
   */
  targetResourceId: Azure.Core.armResourceIdentifier;

  /**
   * The Microsoft Entra principal (object) ID of the identity used by the connection.
   */
  principalId?: Azure.Core.uuid;

  /**
   * The Microsoft Entra tenant ID that the connection identity belongs to.
   */
  tenantId?: Azure.Core.uuid;

  /**
   * The subject name of the certificate used to authenticate the connection.
   */
  certificateSubjectName?: string;

  /**
   * The issuer of the certificate used to authenticate the connection.
   */
  certificateIssuer?: string;

  /**
   * The dSTS principal name used to authenticate the connection.
   */
  dstsPrincipal?: string;

  /**
   * The regional Chaos Studio data-plane endpoint assigned to this connection.
   * Clients and agents use this endpoint to reach the Chaos Studio data plane
   * for the connection.
   */
  @visibility(Lifecycle.Read)
  dataPlaneEndpoint?: url;

  /**
   * The current status of the connection.
   */
  @visibility(Lifecycle.Read)
  status?: ConnectionStatus;

  /**
   * The most recent provisioning state for the connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The kind of connection, indicating the actor type used to reach the target resource's data plane.
 */
union ConnectionKind {
  string,

  /**
   * A connection backed by the Chaos AKS cluster extension.
   */
  AksExtension: "AksExtension",

  /**
   * A connection backed by the Chaos agent installed on the target resource.
   */
  ChaosAgent: "ChaosAgent",

  /**
   * A connection backed by Cloud Service Fault Injection (CSFI).
   */
  Csfi: "Csfi",
}

/**
 * The status of a connection.
 */
union ConnectionStatus {
  string,

  /**
   * The connection has been created but is not yet sending heartbeats; the trust relationship is not yet established.
   */
  Pending: "Pending",

  /**
   * The connection is established and actively heartbeating.
   */
  Connected: "Connected",

  /**
   * The connection's heartbeat has gone stale; heartbeats are no longer being received.
   */
  Disconnected: "Disconnected",

  /**
   * The connection's credentials have been revoked.
   */
  Revoked: "Revoked",
}

/**
 * Model that represents a list of connections and a link for pagination.
 */
model ConnectionListResult is Azure.Core.Page<Connection>;
