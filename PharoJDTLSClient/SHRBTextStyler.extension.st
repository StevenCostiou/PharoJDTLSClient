Extension { #name : 'SHRBTextStyler' }

{ #category : '*PharoJDTLSClient' }
SHRBTextStyler class >> javaStyleTable [
	<styleTable: 'Java'>

			"(symbol color [emphasisSymbolOrArray [textStyleName [pixelHeight]]])"
 ^ #(
  (default                      white)

  "comments"
  (//                           '008000')
  (/*                           '008000')
  (/**                          '008000')

  "strings"
  (string               'A31515')

  "numbers"
  (integer                      '098658')
  (float                        '098658')
  (hex                          '098658')
  (binary                       '098658')

  "keywords"
  (abstract                     '#0000FF')
  (assert                       '#0000FF')
  (boolean                       '#0000FF')
  (break                         '#0000FF')
  (byte                          '#0000FF')
  (case                          '#0000FF')
  (catch                         '#0000FF')
  (char                          '#0000FF')
  (class                         '#0000FF')
  (const                         '#0000FF')
  (continue                      '#0000FF')
  (default                       '#0000FF')
  (do                            '#0000FF')
  (double                        '#0000FF')
  (else                          '#0000FF')
  (enum                          '#0000FF')
  (extends                       '#0000FF')
  (final                         '#0000FF')
  (finally                       '#0000FF')
  (float                         '#0000FF')
  (for                           '#0000FF')
  (goto                          '#0000FF')
  (if                            '#0000FF')
  (implements                    '#0000FF')
  (import                        '#0000FF')
  (instanceof                     '#0000FF')
  ('int'                            '#0000FF')
  (interface                      '#0000FF')
  (long                           '#0000FF')
  (native                         '#0000FF')
  (new                            '#0000FF')
  (package                        '#0000FF')
  (private                        '#0000FF')
  (protected                      '#0000FF')
  (public                         '#0000FF')
  (return                         '#0000FF')
  (short                          '#0000FF')
  (static                         '#0000FF')
  (strictfp                       '#0000FF')
  (super                          '#0000FF')
  (switch                         '#0000FF')
  (synchronized                   '#0000FF')
  (this                           '#0000FF')
  (throw                          '#0000FF')
  (throws                         '#0000FF')
  (transient                      '#0000FF')
  (try                            '#0000FF')
  (void                           '#0000FF')
  (volatile                       '#0000FF')
  (while                          '#0000FF')

  "types"
  (byte                           '#2B91AF')
  (short                          '#2B91AF')
  (int                            '#2B91AF')
  (long                           '#2B91AF')
  (float                          '#2B91AF')
  (double                         '#2B91AF')
  (boolean                        '#2B91AF')
  (char                           '#2B91AF')
  (void                           '#2B91AF')
  (String                         '#2B91AF')
  (Object                         '#2B91AF')
  (Integer                        '#2B91AF')
  (Thread                         '#2B91AF')
  (Exception                      '#2B91AF')
  (RuntimeException               '#2B91AF')

  "methods/functions"
  (main                           '#795E26')
  (println                        '#795E26')
  (print                          '#795E26')
  (equals                         '#795E26')
  (hashCode                        '#795E26')
  (toString                        '#795E26')

  "variables/parameters/fields"
  (args                           '#001080')
  (counter                        '#001080')
  (this                           '#001080')

)
]
