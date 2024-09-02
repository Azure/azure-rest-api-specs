namespace Microsoft.Contoso;

/** Value indicating if the employee likes tea */
union likesTea {
  /** The employee likes tea. */
  yes: "Yes",

  string,
}
