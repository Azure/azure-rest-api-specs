import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;

namespace ConfidentialLedgerCommon;

op LedgerOperation<
  TParameters extends TypeSpec.Reflection.Model = {},
  TResult extends TypeSpec.Reflection.Model | void = void,
  TError = ConfidentialLedgerCommon.ConfidentialLedgerError
> is Azure.Core.Foundations.Operation<TParameters, TResult, {}, TError>;

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
