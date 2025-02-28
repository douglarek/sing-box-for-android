SING-BOX-TAG = 'v1.5.4'
VERSION_CODE = '105023'
VERSION_NAME = 'v1.5.4'

.PHONY: build

build:
	git clone -b $(SING-BOX-TAG) https://github.com/SagerNet/sing-box.git sb-tmp
	$(MAKE) -C sb-tmp lib_install
	$(MAKE) -C sb-tmp lib_android
	mkdir app/libs || true
	cp sb-tmp/libbox.aar app/libs/
	rm -rf sb-tmp
	touch local.properties
	sed -i '/^VERSION_CODE/d' local.properties
	sed -i '/^VERSION_NAME/d' local.properties
	echo VERSION_CODE=$(VERSION_CODE) >> local.properties
	echo VERSION_NAME=$(VERSION_NAME) >> local.properties

bundle:
	./gradlew app:bundleRelease

release:
	./gradlew app:packageRelease
