;;extends
;; Capture the entire outer range for methods
(
  (method_declaration) @function.outer
)

;; Capture just the name of the method
(
  (method_declaration
    name:(identifier) @function.name
  )
)

(
 (class_declaration ) @class.outer
)

(
(class_declaration
  name:(identifier) @class.name)
)

