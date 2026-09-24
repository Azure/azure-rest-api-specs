/**
 * Returns true if a string is a possible full git SHA (40 hex chars, case insensitive)
 */
export function isFullGitSha(string: string): boolean {
  return /^[0-9a-f]{40}$/i.test(string);
}
