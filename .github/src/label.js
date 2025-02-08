// @ts-check

// @ts-nocheck Prevent false positive for duplicate typedef and const names
/**
 * @typedef {"none" | "add" | "remove"} LabelAction
 */

/**
 * @readonly
 * @enum {LabelAction}
 */
export const LabelAction = Object.freeze({
  None: "none",
  Add: "add",
  Remove: "remove",
});
// @ts-check
