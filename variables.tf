variable "rgpolicyname" {
  type = any
}
variable "subspolicyname" {
  type = any
}
variable "mgpolicyname" {
  type = any
}
/*variable "rgpolicyname" {
  type = map(object({
    rgname          = list(string)
    policyname      = list(string)
    subscription_id = string
  }))
}

variable "subspolicyname" {
  type = map(object({
    subsid     = list(string)
    policyname = list(string)
    parameters = any
    (map(object({
      value    = any
    })))
  }))
}

variable "mgpolicyname" {
  type = map(object({
    mgname     = list(string)
    policyname = list(string)
  }))
}*/
