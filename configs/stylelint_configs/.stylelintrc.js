module.exports = {
  plugins: [],
  extends: [
    "stylelint-config-standard",
    "stylelint-config-standard-scss",
    "stylelint-config-recess-order",
  ],
  rules: {
    /* Enforce non-stylistic conventions */
    "declaration-no-important": true,
    "function-url-no-scheme-relative": true,
    /* Enforce non-stylistic conventions */
    "selector-no-qualifying-type": [
      true,
      {
        ignore: "attribute",
      },
    ],
    "selector-id-pattern": [
      "avoid-id-selectors",
      {
        message:
          "Avoid ID selectors because uniqueness is difficult to guarantee (avoid-id-selectors)",
      },
    ],
  },
};
