#!/bin/bash

TERRAFORM_VERSION="1.14.2"
AWS_PROVIDER_VERSION="6.26.0"
BUCKET_SUFFIX="iac-study"

if [ $# -ne 2 ]; then
  echo "Usage: $0 <stage> <module_name>"
  exit 1
fi

STAGE=$1  # dev/stg/prd
MODULE_NAME=$2

ROOTDIR=$(cd "$(dirname $0)"/.. && pwd)
BACKEND_BUCKET_NAME="${STAGE}-tfstate-aws-${BUCKET_SUFFIX}"

if [ "${STAGE}" = "moludes" ] || [ "${STAGE}" = "usecases" ]; then
  MODULE_FLAG=1
  WDIR=${ROOTDIR}/${STAGE}/${MODULE_NAME}
  VIRSION_OPERATOR=">="
else
  MODULE_FLAG=0
  WDIR=${ROOTDIR}/env/${STAGE}/${MODULE_NAME}
  VIRSION_OPERATOR=""
fi
mkdir -p "${WDIR}"
cd "${WDIR}" || exit 1

cat <<EOF > terraform.tf
terraform {
  required_version = "${VIRSION_OPERATOR}${TERRAFORM_VERSION}"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "${VIRSION_OPERATOR}${AWS_PROVIDER_VERSION}"
    }
  }
}
EOF

if [ ${MODULE_FLAG} -ne 1 ]; then
  cat <<EOF > .teffaform-version
${TERRAFORM_VERSION}
EOF

  cat <<EOF > backend.tf
terraform {
  backend "s3" {
    bucket = "${BACKEND_BUCKET_NAME}"
    key = "${MODULE_NAME}/teffaform.tfstate"
    region = "us-east-1"
  }
}
EOF

  cat <<EOF > providers.tf
provider "aws" {
  region = "us-east-1"
  default_tags {
    Terraform = "true"
    STAGE = "${STAGE}"
    MODUlE = "${MODULE_NAME}"
  }
}
provider "aws" {
  alias = "ap_northeast_1"
  region = "ap-northeast-1"
  default_tags {
    Terraform = "true"
    STAGE = "${STAGE}"
    MODUlE = "${MODULE_NAME}"
  }
}
EOF
fi

touch main.tf
touch outputs.tf
touch locals.tf
touch data.tf

if [ ${MODULE_FLAG} -eq 1 ]; then
  touch variables.tf
fi

echo "Files are created in ${WDIR}"