CONTEXT = acme
USERNAME = ""
PASSWORD = ""
VERSION = v3.2
REGISTRY = 10.0.1.1
REGISTRY_SERVER = 172.30.93.229:5000
OUTPUT_DIR = o
BDIR = /build
GO_BUILD=github.com/golang/example/outyet

all: build
build: starter  starter-rhel-atomic  starter-ansible  starter-arbitrary-uid  starter-scratch  starter-systemd  starter-epel  starter-api  starter-nsswrapper
starter: ${OUTPUT_DIR}/starter.o
starter-rhel-atomic: ${OUTPUT_DIR}/starter-rhel-atomic.o
starter-ansible: ${OUTPUT_DIR}/starter-ansible.o
starter-arbitrary-uid: ${OUTPUT_DIR}/starter-arbitrary-uid.o
starter-scratch: ${OUTPUT_DIR}/starter-scratch.o
starter-systemd: ${OUTPUT_DIR}/starter-systemd.o
starter-epel: ${OUTPUT_DIR}/starter-epel.o
starter-api: ${OUTPUT_DIR}/starter-api.o
starter-nsswrapper: ${OUTPUT_DIR}/starter-nsswrapper.o

${OUTPUT_DIR}/starter.o: starter/*
	@mkdir -p ${OUTPUT_DIR}
	docker build --pull -t $(CONTEXT)/starter:$(VERSION) -t $(CONTEXT)/starter starter/	
	@if docker images $(CONTEXT)/starter:$(VERSION); then touch ${OUTPUT_DIR}/starter.o; fi

${OUTPUT_DIR}/starter-rhel-atomic.o: starter-rhel-atomic/*
	@mkdir -p ${OUTPUT_DIR}
	docker build --pull -t $(CONTEXT)/starter-rhel-atomic:$(VERSION) -t $(CONTEXT)/starter-rhel-atomic starter-rhel-atomic/	
	@if docker images $(CONTEXT)/starter-rhel-atomic:$(VERSION); then touch ${OUTPUT_DIR}/starter-rhel-atomic.o; fi
${OUTPUT_DIR}/starter-ansible.o: starter-ansible/*
	@mkdir -p ${OUTPUT_DIR}
	docker build --pull -t $(CONTEXT)/starter-ansible:$(VERSION) -t $(CONTEXT)/starter-ansible starter-ansible/	
	@if docker images $(CONTEXT)/starter-ansible:$(VERSION); then touch ${OUTPUT_DIR}/starter-ansible.o; fi

${OUTPUT_DIR}/starter-arbitrary-uid.o: starter-arbitrary-uid/*
	@mkdir -p ${OUTPUT_DIR}
	docker build --pull -t $(CONTEXT)/starter-arbitrary-uid:$(VERSION) -t $(CONTEXT)/starter-arbitrary-uid starter-arbitrary-uid/	
	@if docker images $(CONTEXT)/starter-arbitrary-uid:$(VERSION); then touch ${OUTPUT_DIR}/starter-arbitrary-uid.o; fi

${OUTPUT_DIR}/starter-scratch.o: starter-scratch/*
	@mkdir -p ${OUTPUT_DIR}
	docker run --rm -tiv ${PWD}/starter-scratch:${BDIR}:z registry.access.redhat.com/rhel7 bash -c "chmod u+x ${BDIR}/build.sh; ${BDIR}/build.sh ${GO_BUILD}"
	docker build --pull -t $(CONTEXT)/starter-scratch:$(VERSION) -t $(CONTEXT)/starter-scratch starter-scratch/	
	@if docker images $(CONTEXT)/starter-scratch:$(VERSION); then touch ${OUTPUT_DIR}/starter-scratch.o; fi

${OUTPUT_DIR}/starter-systemd.o: starter-systemd/*
	@mkdir -p ${OUTPUT_DIR}
	docker build --pull -t $(CONTEXT)/starter-systemd:$(VERSION) -t $(CONTEXT)/starter-systemd starter-systemd/	
	@if docker images $(CONTEXT)/starter-systemd:$(VERSION); then touch ${OUTPUT_DIR}/starter-systemd.o; fi

${OUTPUT_DIR}/starter-epel.o: starter-epel/*
	@mkdir -p ${OUTPUT_DIR}
	docker build --pull -t $(CONTEXT)/starter-epel:$(VERSION) -t $(CONTEXT)/starter-epel starter-epel/	
	@if docker images $(CONTEXT)/starter-epel:$(VERSION); then touch ${OUTPUT_DIR}/starter-epel.o; fi

${OUTPUT_DIR}/starter-api.o: starter-api/*
	@mkdir -p ${OUTPUT_DIR}
	docker build --pull -t $(CONTEXT)/starter-api:$(VERSION) -t $(CONTEXT)/starter-api starter-api/	
	@if docker images $(CONTEXT)/starter-api:$(VERSION); then touch ${OUTPUT_DIR}/starter-api.o; fi

${OUTPUT_DIR}/starter-nsswrapper.o: starter-nsswrapper/*
	@mkdir -p ${OUTPUT_DIR}
	docker build --pull -t $(CONTEXT)/starter-nsswrapper:$(VERSION) -t $(CONTEXT)/starter-nsswrapper starter-nsswrapper/	
	@if docker images $(CONTEXT)/starter-nsswrapper:$(VERSION); then touch ${OUTPUT_DIR}/starter-nsswrapper.o; fi

#test:
#	env NAME=$(NAME) VERSION=$(VERSION) ./test.sh

clean:
	rm -r ${OUTPUT_DIR}/ \
	starter-scratch/*.1 \
	starter-scratch/main

#tag_production:
#	docker tag $(BUILD_NAME_001):latest $(BUILD_NAME_001):production
#	docker tag $(CONTEXT)/$(BUILD_NAME_001):$(VERSION) $(REGISTRY_SERVER)/$(CONTEXT)/$(BUILD_NAME_001):$(VERSION)

#tag_registry:
#	docker tag $(BUILD_NAME_001) $(REGISTRY_SERVER)/$(BUILD_NAME_001)

#push:
#	atomic push -u $(USERNAME) -p $(PASSWORD) $(REGISTRY_SERVER)/$(BUILD_NAME_001):latest
