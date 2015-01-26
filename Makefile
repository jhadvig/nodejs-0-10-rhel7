IMAGE_NAME = ci.dev.openshift.redhat.com:5000/jhadvig/nodejs-0-10-rhel7

build:
	docker build -t $(IMAGE_NAME) .

.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
