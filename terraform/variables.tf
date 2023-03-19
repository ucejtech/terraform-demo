# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  default = "ucejtech"
}

variable "DOCKER_HUB_REPO" {
  type = string
}

variable "CLOUDINARY_API_KEY" {
  type = string
}

variable "CLOUDINARY_API_SECRET" {
  type = string
}

variable "CLOUDINARY_CLOUD_NAME" {
  type = string
}

variable "MONGODB_URL" {
  type = string
}

variable "OPENAI_API_KEY" {
  type = string
}

