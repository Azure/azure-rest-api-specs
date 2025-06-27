import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ConfidentialLedger.Common;

/**
 * An error response from Confidential Ledger.
 */
@error
model ConfidentialLedgerError {
  /**
   * An error response from Confidential Ledger.
   */
  @visibility(Lifecycle.Read)
  error?: ConfidentialLedgerErrorBody;
}

/**
 * An error response from Confidential Ledger.
 */
model ConfidentialLedgerErrorBody {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}
