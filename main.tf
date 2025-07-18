// Copyright (c) 2017, 2024, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Mozilla Public License v2.0

variable "tenancy_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "region" {
}

variable "compartment_id" {
}

variable "instance_type" {
  default = "STANDARDX"
}

variable domain_id {
  default = ""
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

resource "random_integer" "seq" {
  min = 1000
  max = 1100
}

resource "oci_integration_integration_instance" "test_integration_instance" {
  #Required
  compartment_id            = var.compartment_id
  integration_instance_type = var.instance_type
  shape                     = "DEVELOPMENT"
  display_name              = "instance-created-via-tf-${random_integer.seq.result}"
  is_byol                   = "false"
  message_packs             = "1"
  domain_id                 = var.domain_id

  lifecycle {
    ignore_changes = [
      system_tags,
    ]
  }
}
