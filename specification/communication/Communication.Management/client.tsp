import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Communication;

@@clientName(Microsoft.Communication,
  "CommunicationServiceManagementClient",
  "javascript"
);

/**
 * List of VerificationStatusRecord
 */
model DomainPropertiesVerificationStates {
  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Domain?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SPF?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DKIM?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DKIM2?: VerificationStatusRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DMARC?: VerificationStatusRecord;
}
@@alternateType(DomainProperties.verificationStates,
  DomainPropertiesVerificationStates,
  "javascript"
);

/**
 * List of DnsRecord
 */
model DomainPropertiesVerificationRecords {
  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Domain?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SPF?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DKIM?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DKIM2?: DnsRecord;

  /**
   * A class that represents a VerificationStatus record.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DMARC?: DnsRecord;
}
@@alternateType(DomainProperties.verificationRecords,
  DomainPropertiesVerificationRecords,
  "javascript"
);
