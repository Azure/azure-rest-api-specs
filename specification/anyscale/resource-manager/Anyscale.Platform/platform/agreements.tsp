import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./versions.tsp";

using Rest;
using Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Anyscale.Platform;

/** An Anyscale on Azure terms and conditions that a subscription must accept before Anyscale resources can be provisioned. A read-only catalog entry that customers view and accept. */
@subscriptionResource
@resource("agreements")
model Agreement is ProxyResource<AgreementProperties> {
  /** The name that uniquely identifies the agreement (e.g. "default" for the primary terms). */
  @pattern("^[a-zA-Z0-9_-]+$")
  @key("agreementName")
  @path
  @segment("agreements")
  name: string;
}

/** Properties of an Anyscale agreement. All fields are RP-managed (read-only); customers read and accept, they do not author. */
model AgreementProperties {
  /** The provisioning state of the agreement resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The display name of the agreement. */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /** URL to view/download the agreement document. */
  @visibility(Lifecycle.Read)
  agreementLink?: url;

  /** Current status of the agreement. */
  @visibility(Lifecycle.Read)
  status?: AgreementStatus;

  /** Date from which the agreement is effective (UTC). Present once accepted. */
  @visibility(Lifecycle.Read)
  effectiveDate?: utcDateTime;

}

/** The current status of the agreement. */
union AgreementStatus {
  string,

  /** The agreement is available but has not been accepted yet. */
  Pending: "Pending",

  /** The agreement has been accepted and is currently in effect. */
  Active: "Active",
}

@armResourceOperations
interface Agreements {
  /** Get an agreement. Returns the catalog entry (status "Pending") until accepted, then the full signed record. */
  get is ArmResourceRead<Agreement>;

  /** List the agreements available to the subscription. */
  listBySubscription is ArmListBySubscription<Agreement>;

  /** Sign the agreement via PUT. The request body is intentionally empty -- send `{"properties": {}}`. Every agreement property is RP-managed and read-only, so any value supplied in the body is ignored; the accepting identity is taken from the ARM caller token, not the payload. Idempotent -- PUT-ting an already-Active agreement is a no-op. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Agreement>;

  /** Revoke the subscription's acceptance of the agreement. Refused (rejected at validation, before begin) while the subscription still has active Anyscale clouds, since those clouds depend on the accepted agreement -- delete the clouds first. Once permitted, the catalog entry persists (a subsequent GET returns status "Pending") and only the signed record is removed; idempotent. */
  delete is ArmResourceDeleteSync<Agreement>;
}
