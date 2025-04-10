import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MarketplaceOrdering;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union OfferType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  virtualmachine: "virtualmachine",
}

/**
 * Whether the agreement is active or cancelled
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Agreement Terms definition
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AgreementProperties {
  /**
   * Publisher identifier string of image being deployed.
   */
  publisher?: string;

  /**
   * Offer identifier string of image being deployed.
   */
  product?: string;

  /**
   * Plan identifier string of image being deployed.
   */
  plan?: string;

  /**
   * Link to HTML with Microsoft and Publisher terms.
   */
  licenseTextLink?: string;

  /**
   * Link to the privacy policy of the publisher.
   */
  privacyPolicyLink?: string;

  /**
   * Link to HTML with Azure Marketplace terms.
   */
  marketplaceTermsLink?: string;

  /**
   * Date and time in UTC of when the terms were accepted. This is empty if Accepted is false.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  retrieveDatetime?: utcDateTime;

  /**
   * Terms signature.
   */
  signature?: string;

  /**
   * If any version of the terms have been accepted, otherwise false.
   */
  accepted?: boolean;
}

/**
 * ARM resource.
 */
model Resource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The details of the error.
 */
model ErrorResponseError {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Old Agreement Terms definition
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model OldAgreementProperties {
  /**
   * A unique identifier of the agreement.
   */
  id?: string;

  /**
   * Publisher identifier string of image being deployed.
   */
  publisher?: string;

  /**
   * Offer identifier string of image being deployed.
   */
  offer?: string;

  /**
   * Date and time in UTC of when the terms were accepted. This is empty if state is cancelled.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  signDate?: utcDateTime;

  /**
   * Date and time in UTC of when the terms were cancelled. This is empty if state is active.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cancelDate?: utcDateTime;

  /**
   * Whether the agreement is active or cancelled
   */
  state?: State;
}

/**
 * Agreement Terms definition list
 */
model OldAgreementTermsList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value?: OldAgreementTerms[];
}
