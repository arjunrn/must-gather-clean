all: build
.PHONY: all

GO_PACKAGES=$(shell go list ./... | grep -v tools)

# Include the library makefile
include $(addprefix ./vendor/github.com/openshift/build-machinery-go/make/, \
	golang.mk \
	targets/openshift/bindata.mk \
	targets/openshift/deps.mk \
)

verify-scripts: ensure-gojsonschema
	bash -x hack/verify-apigen.sh

.PHONY: verify-scripts
verify: verify-scripts

ensure-gojsonschema:
	hack/ensure-jsonschema.sh
.PHONY: ensure-gojsonschema

update-scripts: ensure-gojsonschema
	hack/update-apigen.sh
.PHONY: update-scripts
