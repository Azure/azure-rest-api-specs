/**
 * @typedef {object} SdkLanguageConfig
 * @property {string} owner
 * @property {string} repository
 * @property {string} titlePrefix
 * @property {string} customAgent
 * @property {string} assignmentCheck
 */

/**
 * @typedef {object} SdkLibraryConfig
 * @property {string} name
 * @property {Readonly<Record<string, Readonly<SdkLanguageConfig>>>} languages
 */

/** @type {Readonly<SdkLibraryConfig>} */
export const aiProjectsLibrary = Object.freeze({
  name: "ai-projects",
  languages: Object.freeze({
    javascript: Object.freeze({
      owner: "Azure",
      repository: "azure-sdk-for-js",
      titlePrefix: "ai-projects",
      customAgent: "ai-projects-regen",
      assignmentCheck: "ai-projects-typespec-regen:v1",
    }),
  }),
});
