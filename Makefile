identity = Developer ID Application: Nindi Gill (7K3HVCLV7Z)
binary = kmart
source = .build/apple/Products/release/$(binary)
destination = /usr/local/bin/$(binary)
pkgproj = KMART.pkgproj

build:
	swift build --configuration release --arch arm64 --arch x86_64
	codesign --sign "$(identity)" --options runtime "$(source)"

install: build
	install "$(source)" "$(destination)"

package: install
	packagesbuild "$(pkgproj)"

uninstall:
	rm -rf "$(destination)"

clean:
	rm -rf .build

.PHONY: build install package uninstall clean
