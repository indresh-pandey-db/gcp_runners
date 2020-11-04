#!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the Licenses.

# set name for this runner as the hostnamee
# shellcheck disable=SC2034
# ACTIONS_RUNNER_INPUT_NAME is used by config.sh
ACTIONS_RUNNER_INPUT_NAME=$HOSTNAME
# get regsistration token for this runnner
#ACTIONS_RUNNER_INPUT_TOKEN="$(curl -sS --request POST --url "https://github.com/pandind/gcp_runners/actions/runners/registration-token" --header "authorization: Bearer AQSHWARKOD73VSKOCSGRH6K7UFDW2"  --header 'content-type: application/json' | jq -r .token)"
 ACTIONS_RUNNER_INPUT_TOKEN=$(curl -sX POST -H "Authorization: token 1fcdbe6d96256fc8116907d97a9c7afea7a1940c" https://api.github.com/repos/pandind/gcp_runners/actions/runners/registration-token | jq -r .token)
# configure runner
export RUNNER_ALLOW_RUNASROOT=1
./config.sh --unattended --replace --work "/tmp" --url https://github.com/pandind/gcp_runners --token "$ACTIONS_RUNNER_INPUT_TOKEN" --labels k8s-runner

# start runner
# https://github.com/actions/runner/issues/246#issuecomment-615293718
./runsvc.sh
