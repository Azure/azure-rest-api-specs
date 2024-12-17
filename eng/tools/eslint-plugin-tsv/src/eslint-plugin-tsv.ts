import kebabCaseFirstPathSegment from "./kebab-case-first-path-segment.js";

export const plugin = {
  rules: {
    [kebabCaseFirstPathSegment.meta.name]: kebabCaseFirstPathSegment,
  },
};

export default plugin;
