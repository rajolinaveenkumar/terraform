variable "instance_type" {
    default = {
        mysql = "t3.micro"
        backend = "t3.micro"
        frontend = "t3.micro"
    }
}

variable "zone_id" {
  default = "Z08677953C60FP1TCJ27I"
}

variable "zone_name" {
  default = "naveenrajoli.site"
}