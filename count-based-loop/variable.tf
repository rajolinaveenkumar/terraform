variable "instances" {
  type = list(string)
  default = ["mysql", "backend", "frontend"]
}

variable "zone_id" {
  default = "Z08677953C60FP1TCJ27I"
}

variable "zone_name" {
  default = "naveenrajoli.site"
}